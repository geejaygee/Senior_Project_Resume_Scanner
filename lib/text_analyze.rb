load "#{Rails.root}/lib/program_words.rb"
load "#{Rails.root}/lib/experience_words.rb"
def analyze (text)
  match=Array.new
    programing_words.each do |key, regex|
      if text=~regex
        match.push(key)
      end
    end
  match.uniq!
  return match
end

def find_certification (text)
  match=Array.new
  certification.each do |key, regex|
    if text=~regex
      match.push(key)
    end
  end  
  match.uniq!
  return match
end

def compare (matching_data)
  result_hash=Hash.new
  start=0
  end_exp=0
  result_edu=0
  result_skill=0
  result_certification=0
  result_skill_group=0
  total_division=0
  if matching_data["experience"]["start"]==true
    start=1
  end
  if matching_data["experience"]["end"]==true
    end_exp=1
  end 
  matching_data["education"].each do |edu, value|
    if value==true
     result_edu=1
    end
    break if value==true
  end
  matching_data["skills"].each do |skill, value|
    if value==true
      result_skill=result_skill+1
    end
  end
  matching_data["certification"].each do |cert, value|
    if value==true
      result_certification=result_certification+1
    end
  end
  matching_data["skill group"].each do |skill, value|
    if value==true
      result_skill_group=result_skill_group+1
    end
  end
  result_hash["experience"]=(((start.to_f+end_exp.to_f)/2)*100).round
  result_hash["education"]=result_edu*100
  if matching_data["skills"].size!=0
    result_hash["skills"]=((result_skill.to_f/matching_data["skills"].size.to_f)*100).round
  else
    result_hash["skills"]=false
  end
  if matching_data["certification"].size!=0
    result_hash["certification"]=((result_certification.to_f/matching_data["certification"].size.to_f)*100).round
  else
    result_hash["certification"]=false
  end
  if matching_data["skill group"].size!=0
    result_hash["skill group"]=((result_skill_group.to_f/matching_data["skill group"].size.to_f)*100).round
  else
    result_hash["skill group"]=false
  end
  result_hash.each do |key, value|
    if value!=false
      total_division=total_division+1
    end
  end
  if matching_data["skill group"].size!=0
    if matching_data["certification"].size!=0
      result_hash["estimated total"]=(((result_hash["experience"].to_f)+(result_hash["education"].to_f)+(result_hash["skill group"].to_f)+(result_hash["certification"].to_f))/total_division).round
    else
     result_hash["estimated total"]=(((result_hash["experience"].to_f)+(result_hash["education"].to_f)+(result_hash["skill group"].to_f))/total_division).round
    end
  else
     result_hash["estimated total"]=false
  end
  if matching_data["certification"].size!=0
    if matching_data["skills"].size!=0
      result_hash["total"]=(((result_hash["experience"].to_f)+(result_hash["education"].to_f)+(result_hash["skills"].to_f)+(result_hash["certification"].to_f))/total_division).round
    else
      result_hash["total"]=(((result_hash["experience"].to_f)+(result_hash["education"].to_f)+(result_hash["certification"].to_f))/total_division).round
    end
  else
    if matching_data["skills"].size!=0
      result_hash["total"]=(((result_hash["experience"].to_f)+(result_hash["education"].to_f)+(result_hash["skills"].to_f))/total_division).round
    else
       result_hash["total"]=(((result_hash["experience"].to_f)+(result_hash["education"].to_f))/total_division).round
    end
  end
  return result_hash
end

def matching(job_data, resume_data)
  matching_data=Hash.new
  matching_data["experience"]=Hash.new
  matching_data["experience"]["start"]=false
  matching_data["experience"]["end"]=false
  matching_data["skills"]=Hash.new
  matching_data["education"]=Hash.new
  matching_data["certification"]=Hash.new
  matching_data["skill group"]=Hash.new
  resume_data["experience"].each do |exp|
    if job_data["experience"]["start"]<=exp["experience"]
      if job_data["industry"]["industry"]==exp["industry"]
        matching_data["experience"]["start"]=true
      end
    end
    if job_data["experience"]["end"]
      if job_data["experience"]["end"]>=exp["experience"]
        if job_data["industry"]["industry"]==exp["industry"]
          matching_data["experience"]["end"]=true
        end
      elsif job_data["experience"]["end"]==0
        matching_data["experience"]["end"]=true
      end
    end
  end
  job_data["skills"].each do |job_skill|
    matching_data["skills"][job_skill]=false
    resume_data["skills"].each do |resume_skill|
      if job_skill==resume_skill
        matching_data["skills"][resume_skill]=true
      end
      break if matching_data["skills"][job_skill]==true
    end
  end
  job_data["education"].each do |job_edu|
    matching_data["education"][job_edu["level"]+job_edu["degree"]]=false
    resume_data["education"].each do |res_edu|
      if job_edu["level"]==res_edu["level"]
        if job_edu["type"]==res_edu["type"]
          matching_data["education"][job_edu["level"]+job_edu["degree"]]=true
        end
      elsif job_edu["level"]=="industry"
        resume_data["experience"].each do |res_exp|
          if job_edu["type"]=="any"
            if res_exp["experience"]>=2
              matching_data["education"][job_edu["level"]+job_edu["degree"]]=true
            end
          elsif res_exp["industry"]==job_edu["type"]
            if res_exp["experience"]>=2
              matching_data["education"][job_edu["level"]+job_edu["degree"]]=true  
            end
          end
          break if matching_data["education"][job_edu["level"]+job_edu["degree"]]==true
        end        
      end
      break if matching_data["education"][job_edu["degree"]]==true
    end
  end 
  job_data["certification"].each do |job_cert|
    matching_data["certification"][job_cert]=false
    resume_data["certification"].each do |res_cert|
      if job_cert==res_cert
        matching_data["certification"][job_cert]=true
      end
      break if matching_data["certification"][job_cert]==true
    end
  end
  job_data["skill group"].each do |skill, value|
    if value==true
      if resume_data["skill group"][skill]==true
        matching_data["skill group"][skill]=true
      else
        matching_data["skill group"][skill]=false
      end
    end
  end
  return matching_data     
end


def initilize_flag
  myflag={"Web"=>false,
          "Database"=>false,
          "Object-Oriented"=>false,
          "Networking"=>false,
          "Embedded"=>false,
          "Backend"=>false,
          "Frontend"=>false,
          "Server"=>false
          }
  return myflag
end

def flag_set (skill_hash)
    myflag=initilize_flag
    skill_hash.each do |skill_word|
      if myflag["Web"]==false
        web_words.each do |key, regex|
          if myflag["Web"]==false
            if skill_word=~regex
              myflag["Web"]=true
            end
          end
        end
      end
      if myflag["Database"]==false
        database_words.each do |key, regex|
          if myflag["Database"]==false
            if skill_word=~regex
              myflag["Database"]=true
            end
          end
        end
      end
      if myflag["Object-Oriented"]==false
        object_oriented_words.each do |key, regex|
          if myflag["Object-Oriented"]==false
            if skill_word=~regex
              myflag["Object-Oriented"]=true
            end
          end
        end
      end
      if myflag["Networking"]==false
        networking_words.each do |key, regex|
          if myflag["Networking"]==false
            if skill_word=~regex
              myflag["Networking"]=true
            end
          end
        end
      end
      if myflag["Embedded"]==false
        embedded_words.each do |key, regex|
          if myflag["Embedded"]==false
            if skill_word=~regex
              myflag["Embedded"]=true
            end
          end
        end
      end
      if myflag["Backend"]==false
        backend_words.each do |key, regex|
          if myflag["Backend"]==false
            if skill_word=~regex
              myflag["Backend"]=true
            end
          end
        end
      end
     if myflag["Frontend"]==false
       frontend_words.each do |key, regex|
         if myflag["Frontend"]==false
           if skill_word=~regex
             myflag["Frontend"]=true
           end
         end
       end
     end
     if myflag["Server"]=false
       server_words.each do |key, regex|
         if myflag["Server"]=false
           if skill_word=~regex
             myflag["Server"]=true
           end
         end
       end
     end
    end
  return myflag
end
