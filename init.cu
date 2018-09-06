#include <thrust/device_vector.h>
#include <thrust/tabulate.h>
#include <iostream>

struct Fragment
{
   int index[3];
   Fragment() = default;
};

struct functor
{
    __device__ __host__
    Fragment operator() (const int &i) const { 
        Fragment f; 
        f.index[0] = i; f.index[1] = i+1; f.index[2] = i+2; 
        return f;
    }
};


int main()
{
    const int N = 10;
    thrust::device_vector<Fragment> dvFragment(N);
    thrust::tabulate(dvFragment.begin(), dvFragment.end(), functor());

    for(auto p : dvFragment) {
        Fragment f = p;
        std::cout << f.index[0] << " " << f.index[1] << " " << f.index[2] << std::endl;
    }

    return 0;
}    