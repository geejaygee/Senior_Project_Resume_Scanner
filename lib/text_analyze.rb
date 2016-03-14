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
