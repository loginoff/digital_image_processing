from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

extensions = [
    Extension("qccpack", ["qccpack.pyx"],
        include_dirs = ['/opt/QccPack/include'],
        libraries = ['QccPack'],
        library_dirs = ['/opt/QccPack/lib']),
    ]
setup(
    name = "My hello app",
    ext_modules = cythonize(extensions),
)

