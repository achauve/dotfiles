#
# Get sources: in ~/local/src/
#    svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python gdb-python


python
import sys
import os.path as osp

sys.path.insert(0, osp.expanduser('~/local/src/gdb-python'))
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)

sys.path.insert(0, osp.expanduser('~/local/src/Boost-Pretty-Printer'))
from boost.v1_40.printers import register_boost_printers
register_boost_printers(None)

sys.path.insert(0, osp.expanduser('~/local/src/eigen3/debug/gdb'))
from printers import register_eigen_printers
register_eigen_printers(None)

end
