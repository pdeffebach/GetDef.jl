module GetDef

export @get, @getdef

function getdef_helper(call, body)
  f_sym = call.args[1]
  f_args = call.args[2:end]
  f_sym_new = Symbol(:get_, f_sym)
  call.args[1] = f_sym_new

  Expr(:function, call, body)
end

macro getdef(call, body)
  x = getdef_helper(call, body)
  esc(x)
end

function add_on_call(f_sym, call)
  storage = call.args[2]
  f_args = call.args[2:end]
  f_sym_new = Symbol(:get_, f_sym)
  f_sym_quotenode = QuoteNode(f_sym)
  call = deepcopy(call)
  call.args[1] = f_sym_new
  s = gensym()
  quote
    $s = $storage
    $f_sym = $get!(() -> $call, $s, $f_sym_quotenode)
  end
end

function get_helper(x)
  if x.head === :tuple
    call = last(x.args)
    f_syms = vcat(x.args[1:(end-1)], last(x.args).args[1])
    new_exprs = add_on_call.(f_syms, Ref(call))
    out = Expr(:block, new_exprs...)
  else
    f_sym = x.args[1]
    add_on_call(f_sym, x)
  end
end

macro get(call)
  esc(get_helper(call))
end

end # Module
