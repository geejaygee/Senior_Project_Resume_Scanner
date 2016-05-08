def level
{"Minor"=>/\b(?i)(Minor)\b/,
"Associate"=>/\b(?i)(Associate)\b/,
"Bachelor of Art"=>/\b(?i)(Bachelor of the arts)|(Bachelor of art(s)?)|(BA)|(B.A.)\b/,
"Bachelor of Science"=>/\b(?i)(BS)|(B.S.)|(Bachelor of Science)|(Bachelor\W?s? degree)|(Bachelor\W?s?)\b/,
"Masters"=>/\b(?i)(Masters)|(MS)|(M.S.)|(Master\W?s?)\b/,
"PHD"=>/\b(?i)(PHD)|(P\.H\.D\.)|(PH\.D\.?)|(PHILOSOPHIAE DOCTOR)|(DOCTOR OF PHILOSOPHY)|(DOCTORATE)\b/
}
end

def degree
{"Computer Science"=>{"Computer Information Systems"=>/\b(?i)(Computer Information Systems)|(CINS)\b/,
               "Computer Science"=>/\b(?i)(Computer Science)|(CS)\b/,
               "Computer Engineer"=>/\b(?i)(Computer Engineering)|(CE)\b/,
               "Information Systems"=>/\b(?i)(Information Systems)|(IS)\b/,
               "Software Engineering"=>/\b(?i)(SOFTWARE ENGINEERING)|(SE)\b/},
"Business"=>{"Accounting"=>/\b(?i)(ACCOUNTING)\b/,
             "Business Administration"=>/\b(?i)(BUSINESS ADMINISTRATION)|(BA)\b/},
"STEM"=>{"STEM"=>/\b(?i)(STEM)|(S\.T\.\E\.M\.)|(SCIENCE, TECHNOLOGY, ENGINEERING, AND MATH)\b/}
}
end

def technical degree
{"Computer Information Systems"=>/\b(?i)(Computer Information System)\b/,
"Computer Science"=>/\b(?i)(Computer Science)\b/,
"Computer Engineer"=>/\b(?i)(Computer Engineering)\b/,
"Information Systems"=>/\b(?i)(Information Systems)\b/
}
end

def jobs
{"technology"=>{"Software Engineer"=>/(?i)(SOFTWARE ENGINEER)/,
                "Computer Repair"=>/(?i)(COMPUTER REPAIR)/,
                 "Technician"=>/(?i)(TECHNICIAN)/},
"customer service"=>{"Cashier"=>/(?i)(CASHIER)/,
                     "Customer Service Representative"=>/(?i)(CUSTOMER SERVICE REPRESENTATIVE)/,
                     "Sales"=>/(?i)(SALES)/},
"Temporary"=>{"Intern"=>/(?i)(INTERN)/,
              "Volunteeer"=>/(?i)(VOLUNTEER)/}
}
end

def certification
{"comptia a"=>/\b(?i)COMPTIA A(\+)?\b/,
"comptia network"=>/\b(?i)COMPTIA NETWORK(\+)?\b/,
"microsoft certified systems engineer"=>/\b(?i)(MCSE)|MICROSOFT CERTIFIED SYSTEMS ENGINEER\b/,
"microsoft certified architect"=>/\b(?i)(MCA)|(MICROSOFT CERTIFIED ARCHITECT)\b/,
"Microsoft Certified Solutions Developer"=>/\b(?i)(MCSD)|(MICROSOFT CERTIFIED SOLUTIONS DEVELOPER)\b/,
"cisco certified internetwork expert"=>/\b(?i)(CCIE)|(CISCO CERTIFIED INTERNETWORK EXPERT)\b/,
"cisco certified security professional"=>/\b(?i)(CCSP)|(CISCO CERTIFIED SECURITY PROFESSIONAL)\b/,
"certified information systems security professional"=>/\b(?i)(CISSP)|(CERTIFIED INFORMATION SYSTEMS SECURITY PROFESSIONAL)\b/,
"Sun Certified Enterprise Architect"=>/\b(?i)(SCEA)|(SUN CERTIFIED ENTERPRISE ARCHITECT)\b/,
"Sun Certified Java Programmer"=>/\b(?i)(SCJP)|(SUN CERTIFIED JAVA PROGRAMMER)\b/,
"systems security certified practitioner"=>/\b(?i)(SSCP)|(SYSTEMS SECURITY CERTIFIED PRACTITIONER)\b/,
"giac security expert"=>/\b(?i)(GSE)|(GIAC SECURITY EXPERT)\b/,
"giac security essentials certification"=>/\b(?i)(GSEC)|(GIAC SECURITY ESSENTIALS CERTIFICATION)\b/,
"giac certified intrusion analyst"=>/\b(?i)(GCIA)|(GIAC CERTIFIED INTRUSION ANALYST)\b/,
"giac certified incident handler"=>/\b(?i)(GCIH)|(GIAC CERTIFIED INCIDENT HANDLER)\b/,
"red hat certified engineer"=>/\b(?i)(RHCE)|(RED HAT CERTIFIED ENGINEER)\b/,
"red hat certified architect"=>/\b(?i)(RHCA)|(RED HAT CERTIFIED ARCHITECT)\b/,
"information technology infrastructure library"=>/\b(?i)(ITTL)|(INFORMATION TECHNOLOGY INFRASTRUCTURE LIBRARY)\b/,
"health insurance portability and accountability act compliance certification"=>/\b(?i)(HIPAA)|(HEALTH INSURANCE PORTABILITY AND ACCOUNTABILITY ACT COMPLIANCE CERTIFICATION)\b/,
"sarbanes-oxley compliance certification"=>/\b(?i)(SOX)|(SARBANES( )?(\-)?( )?OXLEY COMPLIANCE CERTIFICATION)\b/,
"database administration certification"=>/\b(?i)(DAC)|(DATABASE ADMINISTRATION CERTIFICATION)\b/,
"wireless networking certification"=>/\b(?i)(WNC)|(WIRELESS NETWORKING CERTIFICATION(S)?)\b/,
"voice over ip certification"=>/\b(?i)(VOIPC)|(VOICE OVER IP CERTIFICATION(S)?)\b/
}
end

