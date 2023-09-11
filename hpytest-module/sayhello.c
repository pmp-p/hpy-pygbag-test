#include <errno.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#include "hpy.h"




// HPy method: the HPyDef_METH macro generates some boilerplate code,
// the same code can be also written manually if desired
HPyDef_METH(say_hello, "say_hello", HPyFunc_VARARGS)

static HPy say_hello_impl(HPyContext *ctx, HPy self, const HPy *args, size_t nargs)
{
    // Methods take HPyContext, which must be passed as the first argument to
    // all HPy API functions. Other than that HPyUnicode_FromString does the
    // same thing as PyUnicode_FromString.
    //
    // HPy type represents a "handle" to a Python object, but may not be
    // a pointer to the object itself. It should be fully "opaque" to the
    // users. Try uncommenting the following two lines to see the difference
    // from PyObject*:
    //
    // if (self == self)
    //      HPyUnicode_FromString(ctx, "Surprise? Try HPy_Is(ctx, self, self)");
    puts("puts:Hello World");
    return HPyUnicode_FromString(ctx, "Hello world");
}

static HPyDef *hpytest_Methods[] = {
    &say_hello, // 'say_hello' generated for us by the HPyDef_METH macro
    NULL,
};

static HPyModuleDef hpytest_def = {
    .doc = "HPy hpytest_ Example",
    .defines = hpytest_Methods,
};

// The Python interpreter will create the module for us from the
// HPyModuleDef specification. Additional initialization can be
// done in the HPy_mod_exec slot
HPy_MODINIT(hpytest, hpytest_def)

