def level
{"minor"=>/\b(?i)(Minor)\b/,
"Associate"=>/\b(?i)(Associate)\b/,
"ba"=>/\b(?i)(Bachelor of the arts)|(Bachelor of art(s)?)|(BA)|(B.A.)\b/,
"bs"=>/\b(?i)(BS)|(B.S.)|(Bachelor of Science)\b/,
"master"=>/\b(?i)(Masters)|(MS)|(M.S.)\b/
}
end

def degree
{"Computer Information Systems"=>/\b(?i)(Computer Information System)\b/,
"Computer Science"=>/\b(?i)(Computer Science)\b/,
"Computer Engineer"=>/\b(?i)(Computer Engineering)\b/,
"Information Systems"=>/\b(?i)(Information Systems)\b/
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
                "Computer Repair"=>/(?i)(COMPUTER REPAIR)/},
"customer service"=>{"Cashier"=>/(?i)(CASHIER)/,
                     "Customer Service Representative"=>/(?i)(CUSTOMER SERVICE REPRESENTATIVE)/,
                     "Sales"=>/(?i)(SALES)/},
"test"=>{"Intern"=>/(?i)(INTERN)/},
"test2"=>{"Volunteeer"=>/(?i)(VOLUNTEER)/}
}
end
