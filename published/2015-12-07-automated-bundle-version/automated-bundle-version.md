---
tags:
- development
- ruby
---

# Automated Bundle Version

Lately I've been using a script to set my apps’ bundle version.

Add a new Run Script build phase. Change the shell to:

``` sh
/usr/bin/env ruby
```

Put the following in the source area (right under the shell field):

``` ruby
git = `sh /etc/profile; which git`.chomp
app_build = `#{git} rev-list HEAD --count`.chomp.to_i
`/usr/libexec/PlistBuddy -c "Set :CFBundleVersion #{app_build}" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"`
puts "Updated #{ENV['TARGET_BUILD_DIR']}/#{ENV['INFOPLIST_PATH']}"
```

This will automatically set your `CFBundleVersion` to the number of commits in your current branch. TestFlight requires a different bundle version for each build so this automates away having to remember to mess with that.

Enjoy.

**Update 2020-04-01:** If you are using the new Xcode Build System, you need to add `$(TARGET_BUILD_DIR)/$(INFOPLIST_PATH)` as an one of the "Input Files" for this to work.
