Description
===========

Trivial cookbook to manage a list of packages from an attribute.

Attributes
==========

This cookbook has one attribute, `node['packages']`, which determines package names to manage with the `package` resource in Chef in the `packages::default` recipe. It can be specified as an array of strings that are packages to install, or as a hash of packages with an action to take.

In this example:

```ruby
node.default['packages'] = ['git', 'openssl']
```

The `git` and `openssl` packages will be installed.

In this example, using a hash of packages and actions:

```ruby
node.default['packages'] = {'git' => 'install', 'openssl' => 'upgrade', 'xorg-common' => 'remove'}
```

The `git` package will be installed, `openssl` will be upgraded, and `xorg-common` will be removed.

Recipe
=======

default
-------

Simply loops over the contents of `node['packages']` and installs them with the `package` resource.
A custom action can be specified using `node['packages_action']`, such as `'upgrade'`. The default action is `'install'`.

License and Author
==================

Author:: Matt Ray (<matt@getchef.com>)
Author:: Joshua Timberman (<joshua@getchef.com>)

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
