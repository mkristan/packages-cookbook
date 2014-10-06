Description
===========

Trivial cookbook to install a list of packages from an attribute.

Recipe
=======

default
-------

Simply loops over the contents of `node['packages']` and installs them with the `package` resource.
A custom action can be specified using `node['packages_action']`, such as `'upgrade'`. The default action is `'install'`.

License and Author
==================

Author:: Matt Ray (<matt@getchef.com>)

Copyright 2013-2014 Chef Software, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
