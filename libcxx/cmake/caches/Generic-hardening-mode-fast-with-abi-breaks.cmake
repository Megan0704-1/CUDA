set(LIBCXX_HARDENING_MODE "fast" CACHE STRING "")
set(_defines
    _LIBCPP_ABI_BOUNDED_ITERATORS
    _LIBCPP_ABI_BOUNDED_ITERATORS_IN_STRING
    _LIBCPP_ABI_BOUNDED_ITERATORS_IN_VECTOR
    _LIBCPP_ABI_BOUNDED_UNIQUE_PTR
    _LIBCPP_ABI_BOUNDED_ITERATORS_IN_STD_ARRAY
)
set(LIBCXX_ABI_DEFINES "${_defines}" CACHE STRING "")