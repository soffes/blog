# Home Assistant, Sonos, and Siri

Lately, I’ve really been getting into [Home Assistant](https://home-assistant.io). It’s a really fantastic way to connect everything in your house into one place and then control it however you want. I connect everything directly to Home Assistant and then add Home Assistant to HomeKit (Apple’s Home app). So HomeKit is just controlling Home Assistant which is controlling the real devices.

I plan to do a getting started with Home Assistant post at some point. For now, I just want to go over controlling Sonos with Siri. (I specifically want to play Apple Music on Sonos via Siri. [Apparently](https://en.community.sonos.com/announcements-228985/alexa-play-apple-music-on-sonos-6823840) you can do this with Alexa, but I want to use Siri.)

## Approach

The key to using Siri to control things in Home Assistant that aren’t supported in HomeKit is the [Shortcuts](https://apps.apple.com/us/app/shortcuts/id915249334) app. Since things you add here are accessible from Siri, you can create shortcuts for things you want to do and then ask Siri to do them for you.

In this example, let’s setup a shortcut to group all of our Sonos speakers and shuffle a particular playlist.

## Home Assitant Configuration

First, we’ll need to setup some things in Home Assistant.

I have a [group](https://www.home-assistant.io/integrations/group/) called `group.sonos` that is all of my [Sonos](https://www.home-assistant.io/integrations/sonos/) [`media_player`](https://www.home-assistant.io/integrations/media_player/) entities. That’s probably a good place to start. In your configuration, add the following (using your own entity names):

```yaml
group:
  sonos:
    entities:
      - media_player.guest_bathroom
      - media_player.kitchen
      - media_player.living_room
      - media_player.master_bathroom
      - media_player.master_bedroom
      - media_player.office
```

Now let’s create some Home Assistant [scripts](https://www.home-assistant.io/integrations/script) to carry out all of the actions we want to perform.

### Grouping

First, we'll creat a script to group everything together. Before we do that, let’s make sure to turn down the Living Room in case it’s too loud.

```yaml
script:
  # Script to group all Sonos speakers
  sonos_group_all:
    sequence:
      # First, set the volume of the Living Room to 15%. Since this is the TV, it
      # frequently gets turned up much higher and music at this volume is too loud.
      - service: media_player.volume_set
        data:
          entity_id: media_player.living_room
          volume_level: 0.15

      # Now join all of the speakers to the Master Bedroom speaker. (This one is
      # the newest model so it probably has the best CPU if that matters at all.)
      - service: sonos.join
        data:
          master: media_player.master_bedroom
        entity_id:
          - group.sonos
```

Easy enough! Home Assistant [uses services](https://www.home-assistant.io/docs/scripts/service-calls/) to control things in scripts. You can think of these as API calls that take some set of parameters. In Home Assistant, head to Developer Tools > Services and you can explore what’s out there. Adding new integrations will often add more services if it’s a new kind of device.

In the above example, we are using some `media_player` services. You can see in [its documentation](https://www.home-assistant.io/integrations/media_player/) what services are available and what parameters they take. A script is just a sequence of actions you want to perform, so you can see we call two in a row to set things up.

### Playing Music

Let’s do something more interesting though. Let’s play some music!

```yaml
# Play the Chill playlist
sonos_chill:
  sequence:
    # First, group everything
    - service: script.turn_on
      entity_id: script.sonos_group_all

    # Start playing the Chill playlist
    - service: media_player.select_source
      entity_id: group.sonos
      data:
        source: Chill

    # Turn on shuffle
    - service: media_player.shuffle_set
      entity_id: group.sonos
      data:
        shuffle: true
```

You can see we use the `script.turn_on` service to call the script we created in the previous step. Neat!

The `media_player.select_source` needs to choose a source from the media player’s source list. For Sonos, this is just your My Sonos (aka Sonos Favorites). To see the names that Home Assistant sees, head to Developer Tools > States and enter a Sonos entity into the entity box. For example, I used `media_player.master_bedroom`. This will return a `source_list` among other interesting properties.

If you want to play something from Apple Music (or any other source), simply add it to My Sonos (or Sonos Favorite) in the Sonos app.

### Authentication

The last things we’ll need to setup in Home Assistant is a way to enable calls outside of Home Assistant. In the very bottom left of Home Assistant, click your avatar. Scroll to the bottom and create a new Long-Lived Access Token. Be sure to save it somewhere since we’ll need to reference it later.

## Siri Configuration

Now that we can use Home Assistant to do all of this Sonos magic, it would be great if we could just yell at our phone and have Siri trigger it.

First, open [Shortcuts](https://apps.apple.com/us/app/shortcuts/id915249334) and hit the plus to create a new shortcut.

Add a URL action and enter something like this:

```
http://hass.local:8123/api/services/script/sonos_chill
```

Replace the host with wherever your Home Assistant installation is accessible. This will work best if it is available via the Internet and not just your local network.

Now add a Network action. Hit show more. Change the Method to `POST`. Add a Header named `Authorization` and set its value to `Bearer YOUR_ACCESS_TOKEN_HERE` only using the access token you created earlier. Be sure you include `Bearer` and a space before pasting your access token.

Be sure to name it something that makes sense so you can call it from Siri. I named mine “Sonos — Chill” (it will ignore the — when listening). It’s probably best to avoid things like “play” and “music” since the Music app will want to respond to these.

After creating one, be sure to tap it from the main screen Shortucts to run it once. It will ask for permission to access the Internet. Siri can also ask you this, but it’s a bit buggy.

## Conclusion

That’s it! I’ve really been enjoying this approach! You can of course use it for anything—not just Sonos. The possibilities are endless!

If you want to see my ever evolving configuration, it’s on GitHub: [github.com/soffes/home](https://github.com/soffes/home).
