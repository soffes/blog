---
tags:
- development
- swift
---

# Automated Bundle Version

Lately I've been using a script to set my apps’ bundle version.

Add a new Run Script build phase. Change the shell to:

```
/usr/bin/env ruby
```

Put the following in the source area (right under the shell field):

``` ruby
git = `sh /etc/profile; which git`.chomp
app_build = `#{git} rev-list --all | wc -l`.chomp.to_i
`/usr/libexec/PlistBuddy -c "Set :CFBundleVersion #{app_build}" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"`
puts "Updated #{ENV['TARGET_BUILD_DIR']}/#{ENV['INFOPLIST_PATH']}"
```

This will automatically set your `CFBundleVersion` to the number of commits in your current branch. TestFlight requires a different bundle version for each build so this automates away having to remember to mess with that.

Enjoy.
