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

Recent News
-----------

<ul id=recent_news>
{% for post in site.categories.news offset: 0 limit: 8 %}
<li><a title="{{ post.title }}" href="{{ post.url }}" class="submenu_title">{{ post.title }}</a> ({{ post.date | date_to_string }})</li>
{% endfor %}
</ul>
		
<p><a href="/news.html" class="more">View all news »</a></p>

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
  std:generate(h_vec.begin(), h_vec.end(), rand);

  // transfer to device and compute sum
  thrust::device_vector<int> d_vec = h_vec;
  int x = thrust::reduce(d_vec.begin(), d_vec.end(), 0, thrust::plus<int>());
  return 0;
}
{% endhighlight %}
    
Refer to the [Quick Start Guide](http://github.com/thrust/thrust/wiki/Quick-Start-Guide) page for further information and examples.

Contributors
------------

The primary developers of Thrust are [Jared Hoberock](http://github.com/jaredhoberock) and [Nathan Bell](http://research.nvidia.com/users/nathan-bell).


<!---
We have a solution. Let your users take advantage of the Bittorrent protol to download your files and relax your connection while saving money!
PHPTracker is an all-in-one solution for you. It is capable of:

* creating standard .torrent files from any file on your server
* tracking client peers and managing peer announcements
* initially seeding your file with a peer daemon which automatically shuts down once you have enough external seeders!</li>

Why PHPTracker is different? Because it's not "just a tracker", it contains a seeder server too so the distribution of your files is automatic. This is a big step for the content providers to adapt this amazing technology and change the stereotype that "torrent = warez".

See requirements page to see how little you need to set it up (you probably already have all).

## License ##
PHPTracker is free, released under the new (3 clause) [BSD license](/license.html "PHPTracker open-source license").

## Download ##
You can download PHPTracker
  [from Github](https://github.com/tcz/PHPTracker/archives/master "Download PHPTracker packages").

You can also clone the project with [Git](http://git-scm.com "Git version control system")
  by running:

{% highlight bash %}
$ git clone git://github.com/tcz/PHPTracker
{% endhighlight %}
-->
