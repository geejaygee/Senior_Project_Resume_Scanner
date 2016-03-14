load "#{Rails.root}/lib/program_words.rb"

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

def compare (resume, job)
 if job.size>=1
  job.each do |job_word|
    resume.each do |resume_word|
      if resume_word==job_word
        @matching_words.push(resume_word)
      end
    end
  end
  @result=(@matching_words.size.to_f/job.size.to_f)
  return @result
 else
    @result=0
 end
end

def initilize (myflag)
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

def flag_set (resume, myflag)
    myflag=initilize(myflag)
    resume.each do |resume_word|
      if myflag["Web"]==false
        web_words.each do |key, regex|
          if myflag["Web"]==false
            if resume_word=~regex
              myflag["Web"]=true
            end
          end
        end
      end
      if myflag["Database"]==false
        database_words.each do |key, regex|
          if myflag["Database"]==false
            if resume_word=~regex
              myflag["Database"]=true
            end
          end
        end
      end
      if myflag["Object-Oriented"]==false
        object_oriented_words.each do |key, regex|
          if myflag["Object-Oriented"]==false
            if resume_word=~regex
              myflag["Object-Oriented"]=true
            end
          end
        end
      end
    end
return myflag
end
