# Forked from
# https://raw.githubusercontent.com/Valloric/ycmd/66030cd94299114ae316796f3cad181cac8a007c/.ycm_extra_conf.py
# pylint: disable=missing-module-docstring

import platform
import os
import ycm_core # pylint: disable=import-error

DIR_OF_THIS_SCRIPT = os.path.abspath(os.path.dirname(__file__))
DIR_OF_THIRD_PARTY = os.path.join(DIR_OF_THIS_SCRIPT, 'third_party')
SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm']

FLAGS = [
    '-Wall', '-Wextra', '-Werror', '-Wc++98-compat', '-Wno-long-long', '-Wno-variadic-macros',
    '-fexceptions', '-DNDEBUG',

    '-DUSE_CLANG_COMPLETER',
    '-DYCM_EXPORT=',

    '-x',
    '-c++',

    '-isystem',
    '/usr/include',

    '-isystem',
    '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1', # pylint: disable=line-too-long

    '-isystem',
    '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/11.0.0/include', # pylint: disable=line-too-long

    # Node.js and NAN
    '-I', '/Users/xadillax/.nvm/versions/node/v10.16.2/include/node',
    '-I', '/Users/xadillax/.nvm/versions/node/v10.16.2/lib/node_modules/nan'
]

if platform.system() != 'Windows':
    FLAGS.append('-std=c++11')

COMPILATION_DATABASE_FOLDER = ''

if os.path.exists(COMPILATION_DATABASE_FOLDER):
    DATABASE = ycm_core.CompilationDatabase(COMPILATION_DATABASE_FOLDER)
else:
    DATABASE = None

def is_header_file(filename): # pylint: disable=missing-function-docstring
    extension = os.path.splitext(filename)[1]
    return extension in ['.h', '.hxx', '.hpp', '.hh']

def find_corresponding_source_file(filename): # pylint: disable=missing-function-docstring
    if is_header_file(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                return replacement_file
    return filename

def settings(**kwargs): # pylint: disable=missing-function-docstring
    if kwargs['language'] == 'cfamily':
        filename = find_corresponding_source_file(kwargs['filename'])

        if not DATABASE:
            return {
                'flags': FLAGS,
                'include_paths_relative_to_dir': DIR_OF_THIS_SCRIPT,
                'override_filename': filename
            }

        compilation_info = DATABASE.GetCompilationInfoForFile(filename)
        if not compilation_info.compiler_flags_:
            return {}

        final_flags = list(compilation_info.compiler_flags_)

        try:
            final_flags.remove('-stdlib=libc++')
        except ValueError:
            pass

        return {
            'flags': final_flags,
            'include_paths_relative_to_dir': compilation_info.compiler_working_dir_,
            'override_filename': filename
        }

    return {}
