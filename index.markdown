---
layout: default
title: Thrust - Parallel Algorithms Library
<!---description: TODO Index Description-->
---

What is Thrust?
---------------

Thrust is a parallel algorithms library which resembles the C++ Standard
Template Library (STL). Thrust's **high-level** interface greatly enhances
programmer **productivity** while enabling performance portability between
GPUs and multicore CPUs. **Interoperability** with established technologies
(such as CUDA, TBB, and OpenMP) facilitates integration with existing
software. Develop **high-performance** applications rapidly with Thrust!

<!--
Recent News
-----------

<ul id=recent_news>
{% for post in site.categories.news offset: 0 limit: 8 %}
<li><a title="{{ post.title }}" href="{{ post.url }}" class="submenu_title">{{ post.title }}</a> ({{ post.date | date_to_string }})</li>
{% endfor %}
</ul>
		
<p><a href="/news.html" class="more">View all news »</a></p>
--->

Examples
--------

Thrust is best explained through examples. The following source code
generates random numbers serially and then transfers them to a parallel
device where they are sorted.

{% highlight c++ %}
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/generate.h>
#include <thrust/sort.h>
#include <thrust/copy.h>
#include <algorithm>
#include <cstdlib>

int main(void)
{
  // generate 32M random numbers serially
  thrust::host_vector<int> h_vec(32 << 20);
  std::generate(h_vec.begin(), h_vec.end(), rand);

  // transfer data to the device
  thrust::device_vector<int> d_vec = h_vec;

  // sort data on the device (846M keys per second on GeForce GTX 480)
  thrust::sort(d_vec.begin(), d_vec.end());

  // transfer data back to host
  thrust::copy(d_vec.begin(), d_vec.end(), h_vec.begin());

  return 0;
}
{% endhighlight %}
  
This code sample computes the sum of 100 random numbers in parallel:

{% highlight c++ %}
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/generate.h>
#include <thrust/reduce.h>
#include <thrust/functional.h>
#include <algorithm>
#include <cstdlib>

int main(void)
{
  // generate random data serially
  thrust::host_vector<int> h_vec(100);
  std::generate(h_vec.begin(), h_vec.end(), rand);

  // transfer to device and compute sum
  thrust::device_vector<int> d_vec = h_vec;
  int x = thrust::reduce(d_vec.begin(), d_vec.end(), 0, thrust::plus<int>());
  return 0;
}
{% endhighlight %}
    
Refer to the [Quick Start Guide](https://docs.nvidia.com/cuda/thrust/index.html) page for further information and examples.

Contributors
------------

The original creators of Thrust are [Jared Hoberock](http://github.com/jaredhoberock) and [Nathan Bell](http://research.nvidia.com/users/nathan-bell).

