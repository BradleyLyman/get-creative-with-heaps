# Support

This directory contains the support library for demos.

## Testing

```
> haxe build.hxml
```

Test are run automatically as part of the build and a report is generated.
This package does not need to be built for the demos to work, they just include
the src in their classpath.

## Notes

The original plan was to avoid this because I didn't want a potential newcomer
to have to learn some one-off support library *along with* Heaps itself.
But, I've started to run into performance limitations because the Heaps
implementation assumes a certain usage pattern which I am not expressing.

I *really* like the cross platform support, the simple interfaces, and the
general *batteries included* feel that Heaps.io provides. So rather than jump
ship to something like Kha, I'm going to explore building something to address
my different usage.