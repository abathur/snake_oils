# distutils: language=c++
# cython: cpp_locals=True

cdef extern from "<bin/oils_for_unix_preamble.h>" namespace "value_asdl" nogil:
    cdef cppclass LiteralBlock

cdef extern from "<bin/oils_for_unix_preamble.h>" namespace "syntax_asdl" nogil:

    cdef cppclass hnode_t

    cdef cppclass command_t

    cdef cppclass ArgList
    cdef cppclass EnvPair
    cdef cppclass Redir
    cdef cppclass Token
    cdef cppclass word_t

    cdef cppclass command__Simple:
        int tag
        hnode_t* PrettyTree
        command__Simple(Token*, EnvPair*, word_t*, ArgList*, LiteralBlock*, bool, Redir*)
        #  command__Simple(Token* blame_tok, List<EnvPair*>* more_env, List<word_t*>* words, ArgList* typed_args, value_asdl::LiteralBlock* block, bool is_last_cmd, List<Redir*>* redirects)


cdef class py_command__Simple:
    cdef command__Simple c_command

    # def __init__(self):
    #     self.c_command_t = command__Simple()

