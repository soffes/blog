# Debugging JSON Data in LLDB

Recently, I added a snippet to my `~/.lldbinit` for an easy way to print JSON in LLDB. It has saved me a ton of time, so I thought it was worth explaining.

Here’s the snippet:

``` txt
command regex json 's/(.+)/expr let input = %1; print(String(data: try! JSONSerialization.data(withJSONObject: (input is String ? try! JSONSerialization.jsonObject(with: (input as! String).data(using: .utf8)!, options: []) : (input is Data ? (try! JSONSerialization.jsonObject(with: input as! Data, options: [])) : input as! Any)), options: [.prettyPrinted]), encoding: .utf8)!)/'
```

Let’s look at it in an easier to read format. Here’s some Swift psuedocode:

``` swift
func json(input: Any) {
  // Ensure we’re working with a deserialized JSON object
  let object: Any
  if let string = input as? String, let data = string.data(using: .utf8) {
    // If the input was `String`, deserialize it
    object = try! JSONSerialization.jsonObject(with: data, options: []))
  } else if let data = input as? Data {
    // If the input was `Data`, deserialize it
    object = try! JSONSerialization.jsonObject(with: input, options: []))
  } else {
    object = input
  }

  // Convert the object pretty printed JSON data
  let jsonData = try! JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])

  // Convert the pretty printed JSON data to a `String`
  let jsonString = String(data: jsonData, encoding: .utf8)!

  // Print the result
  print(jsonString)
}
```

(Since we’re just using this in the console there are lots of `try!`s and `!`s. Of course, you wouldn’t normally write Swift like this.)

Here’s how it works in action:

``` txt
(lldb) json data
{
  "given_name": "Sam",
  "family_name": "Soffes"
}
```

Instead of `po`, you can now use the new `json` command to pretty print the JSON data or a JSON serializable type (dictionary, array, etc.)

Either copy and paste the snippet into your LLDB console to add the command or add the snippet to `~/.lldbinit` to make it always available.

Hopefully this saves you some time debugging network responses :)
