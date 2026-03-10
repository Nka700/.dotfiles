" Force fenced code block highlighting for vim-markdown (mkd*) syntax.

" --- Bash / sh ---
syntax include @MKD_SH syntax/sh.vim
unlet! b:current_syntax
syntax region mkdFencedSh matchgroup=mkdCodeDelimiter
  \ start='^\s*```\s*\%(bash\|sh\)\s*$'
  \ end='^\s*```\s*$'
  \ keepend
  \ contains=@MKD_SH
  \ containedin=mkdCode,mkdNonListItemBlock

" --- Python ---
syntax include @MKD_PY syntax/python.vim
unlet! b:current_syntax
syntax region mkdFencedPy matchgroup=mkdCodeDelimiter
  \ start='^\s*```\s*python\s*$'
  \ end='^\s*```\s*$'
  \ keepend
  \ contains=@MKD_PY
  \ containedin=mkdCode,mkdNonListItemBlock

" --- YAML (k8s/ansible) ---
syntax include @MKD_YAML syntax/yaml.vim
unlet! b:current_syntax
syntax region mkdFencedYaml matchgroup=mkdCodeDelimiter
  \ start='^\s*```\s*yaml\s*$'
  \ end='^\s*```\s*$'
  \ keepend
  \ contains=@MKD_YAML
  \ containedin=mkdCode,mkdNonListItemBlock

" --- JSON ---
syntax include @MKD_JSON syntax/json.vim
unlet! b:current_syntax
syntax region mkdFencedJson matchgroup=mkdCodeDelimiter
  \ start='^\s*```\s*json\s*$'
  \ end='^\s*```\s*$'
  \ keepend
  \ contains=@MKD_JSON
  \ containedin=mkdCode,mkdNonListItemBlock

" --- C ---
syntax include @MKD_C syntax/c.vim
unlet! b:current_syntax
syntax region mkdFencedC matchgroup=mkdCodeDelimiter
  \ start='^\s*```\s*c\s*$'
  \ end='^\s*```\s*$'
  \ keepend
  \ contains=@MKD_C
  \ containedin=mkdCode,mkdNonListItemBlock

" --- C++ ---
syntax include @MKD_CPP syntax/cpp.vim
unlet! b:current_syntax
syntax region mkdFencedCpp matchgroup=mkdCodeDelimiter
  \ start='^\s*```\s*\%(cpp\|c++\)\s*$'
  \ end='^\s*```\s*$'
  \ keepend
  \ contains=@MKD_CPP
  \ containedin=mkdCode,mkdNonListItemBlock

" --- SQL ---
syntax include @MKD_SQL syntax/sql.vim
unlet! b:current_syntax
syntax region mkdFencedSql matchgroup=mkdCodeDelimiter
  \ start='^\s*```\s*sql\s*$'
  \ end='^\s*```\s*$'
  \ keepend
  \ contains=@MKD_SQL
  \ containedin=mkdCode,mkdNonListItemBlock

" --- Go ---
syntax include @MKD_GO syntax/go.vim
unlet! b:current_syntax
syntax region mkdFencedGo matchgroup=mkdCodeDelimiter
  \ start='^\s*```\s*go\s*$'
  \ end='^\s*```\s*$'
  \ keepend
  \ contains=@MKD_GO
  \ containedin=mkdCode,mkdNonListItemBlock

" --- Terraform ---
syntax include @MKD_TERRAFORM syntax/terraform.vim
unlet! b:current_syntax
syntax region mkdFencedTerraform matchgroup=mkdCodeDelimiter
  \ start='^\s*```\s*terraform\s*$'
  \ end='^\s*```\s*$'
  \ keepend
  \ contains=@MKD_TERRAFORM
  \ containedin=mkdCode,mkdNonListItemBlock

" --- HCL ---
syntax include @MKD_HCL syntax/hcl.vim
unlet! b:current_syntax
syntax region mkdFencedHcl matchgroup=mkdCodeDelimiter
  \ start='^\s*```\s*hcl\s*$'
  \ end='^\s*```\s*$'
  \ keepend
  \ contains=@MKD_HCL
  \ containedin=mkdCode,mkdNonListItemBlock
