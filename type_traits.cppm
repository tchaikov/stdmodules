module;
#include <type_traits>
export module std:type_traits;
export namespace std {
    using std::is_same;
    using std::is_same_v;

    using std::enable_if;
    using std::enable_if_t;

    using std::is_trivially_default_constructible;

    using std::is_constructible;

    using std::is_trivially_destructible;

    using std::is_class;
    using std::is_union;

    using std::is_array;

    using std::extent;

    using std::aligned_union;
    using std::aligned_union_t;
    
    using std::is_floating_point;

    using std::integral_constant;
    using std::false_type;
    using std::true_type;

    using std::remove_cv;
    using std::remove_cv_t;
    using std::remove_reference;

    using std::decay;
    using std::decay_t;
}
