# GetDef

Macros for easily defining functions which generate model parameters and
easily cache them for re-use. 

### Motivation

Consider a model which one external paramter, `z` and a host of endogenous 
parameters in a growing network of dependencies. 

```
x1 = f1(z)
x2 = f2(z, x1)
x3 = f3(z, x1, x2)
```

and so on. We want an easy way to keep track of endogenous objects `x` without calling
`f1`, etc. every time. 

Additionally, there may be a complicated dependency tree of endogenous parameters
and we don't want to keep track of which functions require which arguments. 

### `@getdef`: Defining a "getter" function

The `@getdef` macro is a way to calculate an exogenous model objects and cache them. 


### `@get`: Retrieving parameters

