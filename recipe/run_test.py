import os
import sys
import numpy

import numpy.core.multiarray
import numpy.core._multiarray_tests
import numpy.core.numeric
import numpy.core._operand_flag_tests
import numpy.core._struct_ufunc_tests
import numpy.core._rational_tests
import numpy.core.umath
import numpy.core._umath_tests
import numpy.linalg.lapack_lite
import numpy.random.mtrand

import ctypes
import numpy as np

ctypes.windll.kernel32.GetModuleHandleExA.argtypes = (
         ctypes.c_uint32, ctypes.c_void_p, 
ctypes.POINTER(ctypes.c_void_p))

res = ctypes.c_void_p()
ctypes.windll.kernel32.GetModuleHandleExA(
         4|2, np.core._multiarray_umath._discover_cblas_funcpointer(), 
res)


cblas = ctypes.CDLL("cblas", handle=res.value)

# Lets see if we got Python (because cblas does not exist):
try:
     cblas.PyLong_FromLong
     print("Hmmm, only python here, was CBLAS linked?")
     import sys
     sys.exit
except:
     print("not python :)")

# Does the capitalization matter? I had this, but maybe lower case:
print(cblas.MKL_Get_Max_Threads())
