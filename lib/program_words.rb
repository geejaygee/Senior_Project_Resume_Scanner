def programing_words
{ ".net"=> /\b(?i)\.net/,
"bash"=>/\b(?i)bash\b/,
"ruby"=>/\b(?i)ruby\b/,
"c"=>/\b(?i)c\b/,
"c#"=>/\b(?i)c\#/,
"c++"=>/\b(?i)c\+{2}/,
"java"=>/\b(?i)java\b/,
"javascript"=>/\b(?i)javascript\b/,
"python"=>/\b(?i)python\b/,
"php"=>/\b(?i)php\b/,
"perl"=>/\b(?i)perl\b/, 
"visual basic .net"=>/\b(?i)((visual\sbasic\s\.net)| \bvisual\sbasic\.net)/,
"visual basic"=>/\b(?i)(visual\sbasic)/,
"html"=>/\b(?i)HTML\b/,
"css"=>/\b(?i)(CASCADING STYLE SHEETS)|(CSS[123]{0,1})\b/,
"mysql"=>/\b(?i)MYSQL\b/,
"ruby on rails"=>/\b(?i)(RUBY ON RAILS)|(ROR)\b/,
"sql"=>/\b(?i)SQL\b/,
"xml"=>/\b(?i)XML\b/,
"silktest"=>/\b(?i)SILKTEST\b/
}
end

def os_words
{ "linux"=>/\b(?i)LINUX\b/,
"windows"=>/\b(?i)WINDOWS\b/,
"android"=>/\b(?i)ANDROID\b/,
"snow lepard"=>/\b(?i)SNOW LEPARD\b/,
"os x"=>/\b(?i)OS X\b/,
"unix"=>/\b(?i)UNIX\b/,
"red hat"=>/\b(?i)RED HAT\b/,
"ios"=>/\b(?i)IOS\b/,
"aws"=>/\b(?i)(AWS)|(AMAZON WEB SERVICE[S]{0,1})\b/
}
end

def test_automation_words
{ "perl"=>/\b(?i)PERL\b/,
"visual basic"=>/\b(?i)VISUAL BASIC\b/,
"vb.net"=>/\b(?i)(VB\.NET)|(VB \.NET)\b/,
"c#"=>/\b(?i)c\#\b/
}
end

def web_dev_words
{ "html"=>/\b(?i)HTML\b/,
"vbscript"=>/\b(?i)(VBSCRIPT)|(VB SCRIPT)\b/,
"php"=>/\b(?i)PHP\b/,
"javascript"=>/\b(?i)JAVASCRIPT\b/,
"vb.net"=>/\b(?i)(VB\.NET)|(VB \.NET)\b/,
"c#"=>/\b(?i)C\#\b/,
"ruby on rails"=>/\b(?i)(RUBY ON RAILS)|(ROR)\b/,
"css"=>/\b(?i)(CASCADING STYLE SHEETS)|(CSS[123]{0,1})\b/,
"asp.net"=>/\b(?i)(ASP\.NET)|(ASP \.NET)\b/,
"AJAX"=>/\b(?i)(AJAX)|(ASYNCHRONOUS JAVASCRIPT AND XML)\b/
} 
end

def embedded_words
{"c"=>/\b(?i)C\b/,
"c++"=>/\b(?i)C\+{2}\b/,
"java"=>/\b(?i)JAVA\b/,
"javascript"=>/\b(?i)JAVASCRIPT\b/,
"python"=>/\b(?i)python\b/,
"assembly"=>/\b(?i)ASSEMBLY LANGUAGE[S]{0,1}\b/
}
end
