# Nilable [![Build Status](https://travis-ci.org/gsamokovarov/nilable.svg)](https://travis-ci.org/gsamokovarov/nilable)

Nilable object is a tool to handle nil invocations.

Any nilable object wraps a single value object and proxy method invocations to
it. In turn, every method result is wrapped in an nilable object.

If somewhere along the call chain, a method result is `nil`, no `NoMethodError`
will be raised and you can keep on chaining method calls. It acts as a black
hole object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nilable'
```

## Usage

Nilable objects come to the rescue, when you're working on legacy code bases,
where you can't avoid the nils and you have to deal with them. In fresh
projects, you don't wanna use nilable objects, but avoid leaking the nils in
the first place. With that out of the way, here is how you can use the nilable
objects.

Imagine a legacy system where an user has an account. There are no database
constraints and `User#account` can always be nil. In fact, it already is in old
production users.

Every time you get to work with an user object and have to get its account, you
have to check whether its nil. Even worse, if the account has nilable fields as
well, you have to check them too:

```ruby
def format_currency(user)
  if account = user.account
    if currency = account.currency
      currency.format
    end
  end
end
```

Forget one check and you break. Forget a test and you break in production.

In such hostile systems, you can use the nilable objects to save yourself all
those checks. Wrap your hostile objects and call your methods away. If a `nil`
happens anywhere in the call chain, another nilable object will be returned.
When done, call `Nilable#value` to extract the value out of the nilable object.

```ruby
def format_currency(user)
  Nilable(user.account).currency.format.value
end
```

That's it. Wrap your hostile objects in nilable and have your newer code free
of defensive nil checks.

## Credits

What I call a nilable object, is well documented in the wild as the [Option
type]. There are many implementations of it in Ruby land, with the most popular
of them being [Tom Stuart]'s [monads]. If you need more utils to deal with your
nils, check it out.

Where nilable shines for me, is the simple implementation. That's all I need
for my legacy projects.

[Option type]: https://en.wikipedia.org/wiki/Option_type
[monads]: https://github.com/tomstuart/monads
[Tom Stuart]: https://github.com/tomstuart
