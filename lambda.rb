i = '(λy. (λx. x) y) ((λu. u) (λv. v))'


# cursor = i.length
#
# while true
#   c = i[cursor]
#   if c != 'λ'
#     cursor--
#   else
#
# end


zero = -> f { -> x {x}}
one = -> f { -> x {f[x]} }

x = -> f { f *f }

def to_integer(proc)
  proc[-> n { n - 1 }][10]
end