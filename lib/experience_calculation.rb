load "#{Rails.root}/lib/experience_words.rb"

def experience_calc(resume_text)
  array=Array.new
  jobs.each do |key, hash|
    hash.each do |key2, regex|
      if position=resume_text.scan(regex)
        position.uniq!
        position.each do |pos|
          if ((experience_start=resume_text.scan(/(?<=#{pos[0]})(?:\s|\.|\,|\-|\–)*(?:(?!(?i)(?:SPRING)|(?:SUMMER)|(?:FALL)|(?:AUTUMN)|(?:WINTER))\w*\b\,?\.?\-?\s?){,5}(?:\s|\.|\,|\-|\–)*(((\d{1,2})(\/|\-)(\d{1,2})?(\/|\-)?(\d{4}|\d{1,2}))|((?i)((SPRING)|(SUMMER)|(FALL)|(AUTUMN)|(WINTER)|(JANUARY)|(JAN\.?)|(FEBRUARY)|(FEB\.?)|(MARCH)|(MAR\.?)|(APRIL)|(APR\.?)|(MAY)|(JUNE)|(JUN\.?)|(JULY)|(JUL\.?)|(AUGUST)|(AUG.?)|(SEPTEMBER)|(SEPT\.?)|(OCTOBER)|(OCT\.?)|(NOVEMBER)|(NOV\.?)|(DECEMBER)|(DEC\.?))(\s|\-|\/)?(\d{2}|\d{1})?(\,)?(\s|\-|\/)?(\d{4}|\d{2}))|(\d{4}))/)).size!=0)
            total=0
            experience_start.each do |exp|
              if ((experience_end=resume_text.scan(/(?<=#{exp[0]})(?:\s|\.|\,|\-|\–|(?i)to)*(((\d{1,2})(\/|\-)(\d{1,2})?(\/|\-)?(\d{4}|\d{1,2}))|((?i)((SPRING)|(SUMMER)|(FALL)|(AUTUMN)|(WINTER)|(JANUARY)|(JAN\.?)|(FEBRUARY)|(FEB\.?)|(MARCH)|(MAR\.?)|(APRIL)|(APR\.?)|(MAY)|(JUNE)|(JUN\.?)|(JULY)|(JUL\.?)|(AUGUST)|(AUG\.?)|(SEPTEMBER)|(SEPT\.?)|(OCTOBER)|(OCT\.?)|(NOVEMBER)|(NOV\.?)|(DECEMBER)|(DEC\.?))(\s|\-|\/)?(\d{2}|\d{1})(\,)?(\s|\-|\/)?(\d{4}|\d{2}))|(\d{4})|((?i)(PRESENT)|(CURRENT)))/)).size!=0)
                  value1=num_conv exp[0]
                  value2=num_conv experience_end[0][0]
                  value3=difference value1, value2
                  total=total+value3
              else
                value1=num_conv exp[0]
                value2=value1 >> 3
                value3=difference value1, value2
                total=total+value3
              end
            end
            hash=Hash.new
            hash["industry"]=key
            hash["position"]=pos[0]
            hash["experience"]=total
            array.push(hash)
          elsif ((experience_end=resume_text.scan(/(((\d{1,2})(\/|\-)(\d{1,2})(\/|\-)(\d{4}|\d{1,2}))|((?i)((SPRING)|(SUMMER)|(FALL)|(AUTUMN)|(WINTER)|(JANUARY)|(JAN\.?)|(FEBRUARY)|(FEB\.?)|(MARCH)|(MAR\.?)|(APRIL)|(APR\.?)|(MAY)|(JUNE)|(JUN\.?)|(JULY)|(JUL\.?)|(AUGUST)|(AUG\.?)|(SEPTEMBER)|(SEPT\.?)|(OCTOBER)|(OCT\.?)|(NOVEMBER)|(NOV\.?)|(DECEMBER)|(DEC\.?))(\s|\-|\/)?(\d{2}|\d{1})(\,)?(\s|\-|\/)?(\d{4}|\d{2}))|(\d{4})|((?i)(PRESENT)))(?:\s|\.|\,|\-|\–)*(?:(\w*(\,|\.|\-)?\s){5})(?:(?!(?i)(?:SPRING)|(?:SUMMER)|(?:FALL)|(?:AUTUMN)|(?:WINTER))\w*\b\,?\.?\-?\s?){,5}(?=(?i)#{pos[0]})/)).size!=0)
            total=0
            experience_end.each do |exp|
              if ((experience_start=resume_text.scan(/(((\d{1,2})(\/|\-)(\d{1,2})?(\/|\-)?(\d{4}|\d{1,2}))|((?i)((SPRING)|(SUMMER)|(FALL)|(AUTUMN)|(WINTER)|(JANUARY)|(JAN\.?)|(FEBRUARY)|(FEB\.?)|(MARCH)|(MAR\.?)|(APRIL)|(APR.?)|(MAY)|(JUNE)|(JUN\.?)|(JULY)|(JUL\.?)|(AUGUST)|(AUG\.?)|(SEPTEMBER)|(SEPT\.?)|(OCTOBER)|(OCT\.?)|(NOVEMBER)|(NOV\.?)|(DECEMBER)|(DEC\.?))(\s|\-|\/)?(\d{2}|\d{1})(\,)?(\s|\-|\/)?(\d{4}|\d{2}))|(\d{4}))(?:\s|\.|\,|\-|\–|(?i)to)*(?=#{exp[0]})/)).size!=0)
                value1=num_conv experience_start[0][0]
                value2=num_conv exp[0]
                value3=difference value1, value2
                total=total+value3
              else
                value2=num_conv exp[0]
                value1=value1+3.months
                value3=difference value1, value2
                total=total+value3
              end
            end
            hash=Hash.new
            hash["industry"]=key
            hash["position"]=ind[0]
            hash["experience"]=total
            array.push(hash)
          end
        end
      end
    end
  end
  return array
end

def job_industry(position, job_text)
  flag=false
  industry=String.new
  industry="other"
  jobs.each do |key, hash|
    if flag==false
      hash.each do |key2, regex|
        if (position=~regex)
          industry=key
          flag=true
        end
      end
    end
  end
  return industry
end

def experience_calc_job (job_text)
  experience_hash={"start"=>0, "end"=>0}
  if ((experience=job_text.scan(/(?<!\s\-\s|\-)\d{1,2}(?:(?i)\+?\s?(?:YEAR)(?:S)?.?\s(?:of)?)/)).size!=0)
    if (experience_hash["start"] < experience[0][0].to_i)
       experience_hash["start"]=experience[0][0].to_i
       experience_hash["end"]=100
    end
  end
  if ((experience_start=job_text.scan(/(\d{1,2})\s?(?:\-|\s\d{1,2})/)).size!=0)
    experience.uniq!
    experience.compact!
    experience_start.each do |exp|
      if ((experience_end=job_text.scan(/(?<=#{exp[0]})(?:\s?\-\s?)(\d{1,2})(?:(?i)\+?\s?(?:YEAR)(?:S)?.?\s(?:of)?)/)).size!=0)
        if (experience_hash["start"] < exp[0].to_i)
          experience_hash["start"]=exp[0].to_i
          experience_hash["end"]=experience_end[0][0].to_i
        end
      end
    end
  end
  return experience_hash
end

def difference dat1, dat2
  if dat2 < (20.year.ago).to_date
    return ((dat2-dat1)*0.5).to_i
  elsif dat2 < (10.year.ago).to_date
    return ((dat2-dat1)*0.7).to_i
  elsif dat2 < (5.year.ago).to_date
    return ((dat2-dat1)*0.9).to_i
  else
    return (dat2-dat1).to_i
  end
end

def num_conv date1
  if date1=~/(\d{1,2})(\/|-)(\d{4}|\d{1,2})(\/|\-)?(\d{4}|\d{1,2})?/
    if $5==nil
      dat1=DateTime.parse($3+"-"+$1+"-1").to_date
    else
      dat1=DateTime.parse($5+"-"+$1+"-"+$3).to_date
    end
  elsif date1=~/(?i)((JANUARY)|(JAN\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-1-1").to_date
    else
      dat1=DateTime.parse($8+"-1-"+$5).to_date
    end
  elsif date1=~/(?i)((FEBRUARY)|(FEB\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-2-1").to_date
    else
      dat1=DateTime.parse($8+"-2-"+$5).to_date
    end
  elsif date1=~/(?i)((MARCH)|(MAR\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-3-1").to_date
    else
      dat1=DateTime.parse($8+"-3-"+$5).to_date
    end
  elsif date1=~/(?i)((APRIL)|(APR\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-4-1").to_date
    else
      dat1=DateTime.parse($8+"-4-"+$5).to_date
    end
  elsif date1=~/(?i)((MAY)|(MAY\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-5-1").to_date
    else
      dat1=DateTime.parse($8+"-5-"+$5).to_date
    end
  elsif date1=~/(?i)((JUNE)|(JUN\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-6-1").to_date
    else
      dat1=DateTime.parse($8+"-6-"+$5).to_date
    end
  elsif date1=~/(?i)((JULY)|(JUL\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-7-1").to_date
    else
      dat1=DateTime.parse($8+"-7-"+$5).to_date
    end
  elsif date1=~/(?i)((AUGUST)|(AUG\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-8-1").to_date
    else
      dat1=DateTime.parse($8+"-8-"+$5).to_date
    end
  elsif date1=~/(?i)((SEPTEMBER)|(SEPT\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-9-1").to_date
    else
      dat1=DateTime.parse($8+"-9-"+$5).to_date
    end
  elsif date1=~/(?i)((OCTOBER)|(OCT\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-10-1").to_date
    else
      dat1=DateTime.parse($8+"-10-"+$5).to_date
    end
  elsif date1=~/(?i)((NOVEMBER)|(NOV\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-11-1").to_date
    else
      dat1=DateTime.parse($8+"-11-"+$5).to_date
    end
  elsif date1=~/(?i)((DECEMBER)|(DEC\.?))(\s|\-|\/)(\d{4}|\d{1,2})?(\,)?(\s|\-|\/)?(\d{4}|\d{2})?/
    if $8==nil
      dat1=DateTime.parse($5+"-12-1").to_date
    else
      dat1=DateTime.parse($8+"-12-"+$5).to_date
    end
  elsif date1=~/(?i)(SPRING)\s(\d{4})?/
    if $2==nil
      dat1=DateTime.parse("2016-3-1")
    else
      dat1=DateTime.parse($2+"-3-1")
    end
  elsif date1=~/(?i)(SUMMER)\s(\d{4})?/
    if $2==nil
      dat1=DateTime.parse("2016-6-1")
    else
      dat1=DateTime.parse($2+"-6-1")
    end
  elsif date1=~/(?i)(FALL)|(AUTUMN)\s(\d{4})?/
    if $2==nil
      dat1=DateTime.parse("2016-9-1")
    else
      dat1=DateTime.parse($2+"-9-1")
    end
  elsif date1=~/(?i)(WINTER)\s(\d{4})?/
    if $2==nil
      dat1=DateTime.parse("2016-12-1")
    else
      dat1=DateTime.parse($2+"-12-1")
    end
  elsif date1=~/(?i)(PRESENT)|(CURRENT)/
    dat1=DateTime.now.to_date
  elsif date1=~/(\d{4})/
    dat1=DateTime.parse($1+"-1-1").to_date
  end
  return dat1
end

def education (resume_text)
  myarray=Array.new
  level.each do |key3, regex_type|
    degree.each do |key, hash|
      hash.each do |key2, regex_degree|
        myregex=(Regexp.new(regex_type.to_s+'(\s)?((?i)IN|OF)?(\s)?'+regex_degree.to_s))
          if ((education=resume_text.scan(myregex)).size!=0)
            myhash=Hash.new
            myhash["time"]=0
            myhash["start"]=education[0]
            if ((experience_start=resume_text.scan(/(?<=#{education[0].join})(?:\s|\.|\,|\-|\–|\(|\))*(?:(?!(?i)(?:SPRING)|(?:SUMMER)|(?:FALL)|(?:AUTUMN)|(?:WINTER)|(?:JANUARY)|(?:JAN\.?)|(?:FEBRUARY)|(?:FEB\.?)|(?:MARCH)|(?:MAR\.?)|(?:APRIL)|(?:APR\.?)|(?:MAY)|(?:JUNE)|(?:JUN\.?)|(?:JULY)|(?:JUL\.?)|(?:AUGUST)|(?:AUG.?)|(?:SEPTEMBER)|(?:SEPT\.?)|(?:OCTOBER)|(?:OCT\.?)|(?:NOVEMBER)|(?:NOV\.?)|(?:DECEMBER)|(?:DEC\.?))\w*\b\W*){,5}(?:\s|\.|\,|\-|\–|\(|\))*(((\d{1,2})(\/|\-)(\d{1,2})?(\/|\-)?(\d{4}|\d{1,2}))|((?i)((SPRING)|(SUMMER)|(FALL)|(AUTUMN)|(WINTER)|(JANUARY)|(JAN\.?)|(FEBRUARY)|(FEB\.?)|(MARCH)|(MAR\.?)|(APRIL)|(APR\.?)|(MAY)|(JUNE)|(JUN\.?)|(JULY)|(JUL\.?)|(AUGUST)|(AUG.?)|(SEPTEMBER)|(SEPT\.?)|(OCTOBER)|(OCT\.?)|(NOVEMBER)|(NOV\.?)|(DECEMBER)|(DEC\.?))(\s|\-|\/)?(\d{2}|\d{1})?(\,)?(\s|\-|\/)?(\d{4}|\d{2}))|(\d{4}))/)).size!=0)
              value1=num_conv experience_start[0][0]
              value2=num_conv "present"
              myhash["start"]=education[0].join
              myhash["time"]=difference value1, value2
            end
            myhash["level"]=key3
            myhash["degree"]=key2
            myhash["type"]=key
            myarray.push(myhash)
          end
      end
    end
  end
  certification.each do |key, regex|
    if resume_text.match(regex)
      myhash=Hash.new
      myhash["level"]="blank space"
      myhash["degree"]=key
      myhash["type"]="certificate"
      myhash["time"]=0
      myhash["start"]=0
      myarray.push(myhash)
    end
  end
  return myarray              
end

def education_req (job_text, position)
  myarray=Array.new
  match=false
  level.each do |key3, regex_type|
    degree.each do |key, hash|
      hash.each do |key2, regex_degree|
        myregex=(Regexp.new(regex_type.to_s+'(\s?\(?\b\w*\W?\w*\b\)?\s?){,5}\s((?i)IN|OF)?\s?'+regex_degree.to_s))
          if ((education=job_text.scan(myregex)).size!=0)
            myhash=Hash.new
            myhash["level"]=key3
            myhash["degree"]=key2
            myhash["type"]=key
            myarray.push(myhash)
            education[0].compact!
            if match==false
              if ((experience=job_text.scan(/(?<=#{education[0][2]})\s(?:((\b\w*\b\,?\s)|\(|\))){,10}(?i)or\s(?:(?!(?i)(with)|(and))\b\w*\b\s?){,5}(?i)experience/)).size!=0)
                jobs.each do |job_key, hash|
                  hash.each do |job_hash_key, job_hash_regex|
                    if ((work_experience=position.scan(job_hash_regex)).size!=0)
                      myhash=Hash.new
                      myhash["level"]="industry"
                      myhash["degree"]=job_key
                      myhash["type"]="industry"
                      match=true
                      myarray.push(myhash)
                    else
                      myhash=Hash.new
                      myhash["level"]="industry"
                      myhash["degree"]="any"
                      myhash["type"]="industry"
                      match=true
                      myarray.push(myhash) 
                    end 
                  end
                end
              end
            end
          end
      end
    end
  end
  certification.each do |key, regex|
    if job_text.match(regex)
      myhash=Hash.new
      myhash["level"]="blank space"
      myhash["degree"]=key
      myhash["type"]="certificate"
      myarray.push(myhash)
    end
  end
  return myarray
end
