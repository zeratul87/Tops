%module jetCorrection

%{
#include <stddef.h>
#include"JetMETObjects/JetCorrectorParameters.h"
#include"JetMETObjects/FactorizedJetCorrector.h"
#include"JetMETObjects/JetCorrectionUncertainty.h"
#include"JECvariation.h"
#include"EventTree.h"
#include <TH1F.h>
#include <TFile.h>
#include <TChain.h>
#include <vector>
%}

%include "typemaps.i"
%include "std_vector.i"
%include "std_string.i"
%include "cstring.i"
%include "cpointer.i"


namespace std {

        %template(IntVector) std::vector<int>;
        %template(FloatVector) std::vector<float>;
        
};

%pointer_functions(std::vector<int>, p_vi);
%pointer_functions(std::vector<float>, p_vf);
/*%pointer_functions(TChain, p_TChain);
*/

%typemap(in) char ** {
  /* Check if is a list */
  if (PyList_Check($input)) {
    int size = PyList_Size($input);
    int i = 0;
    $1 = (char **) malloc((size+1)*sizeof(char *));
    for (i = 0; i < size; i++) {
      PyObject *o = PyList_GetItem($input,i);
      if (PyString_Check(o))
        $1[i] = PyString_AsString(PyList_GetItem($input,i));
      else {
        PyErr_SetString(PyExc_TypeError,"list must contain strings");
        free($1);
        return NULL;
      }
    }
    $1[i] = 0;
  } else {
    PyErr_SetString(PyExc_TypeError,"not a list");
    return NULL;
  }
}

/*This cleans up the char ** array we malloc'd before the function call*/
%typemap(freearg) char ** {
  free((char *) $1);
}

/* Allows the class to be picklable */

/*%extend PUReweight {*/
%pythoncode {
    import pickle
#    __safe_for_unpickling__ = True
    def _pickle_method(method):
        func_name = method.im_func.__name__
        obj = method.im_self
        cls = method.im_class
        if func_name.startswith('__') and not func_name.endswith('__'):
            cls_name = cls.__name__.lstrip('_')
        if cls_name: func_name = '_' + cls_name + func_name
        return _unpickle_method, (func_name, obj, cls)

    def _unpickle_method(func_name, obj, cls):
        for cls in cls.mro():
            try:
                func = cls.__dict__[func_name]
            except KeyError:
                pass
            else:
                break
        return func.__get__(obj, cls)

        import copy_reg
        import types
        copy_reg.pickle(types.MethodType, _pickle_method, _unpickle_method)
}
/*}*/
/*
%extend PUReweight {
%pythoncode {
    __safe_for_unpickling__ = True
    def generic_setstate(self, dict):
        self.__init__()
        for key, value in dict.iteritems():
            setattr(self, key, value)

    def generic_getstate(self):
        return dict((var, getattr(self, var)) for var in 

    __pickle_vars__[self.__class__.__name__])
    #__pickle_vars__ = { 'myclass' : ['x', 'y'], 'myclass2' : ['zz'], ... }

    __getstate__=generic_getstate
    __setstate__=generic_setstate
#    def __reduce__(self):
#        return (PUReweight, self.Get())
#        args = self.getNFiles(), self.getFileNames(), self.getPUFilename()
#        return self.__class__, args
}
}
*/

%include "EventTree.h"
%include "JECvariation.h"

