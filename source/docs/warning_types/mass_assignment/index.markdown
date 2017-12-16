---
layout: page
title: "Mass Assignment"
date: 2011-11-09 14:37
comments: false
sharing: true
footer: true
---

Mass assignment is a feature of Rails which allows an application to create a record from the values of a hash.

Example:

    User.new(params[:user])

Unfortunately, if there is a user field called `admin` which controls administrator access, now any user can make themselves an administrator with a query like

    ?user[admin]=true

### Rails With Strong Parameters

In Rails 4 and newer, protection for mass assignment is on by default.

Query parameters must be explicitly whitelisted via `permit` in order to be used in mass assignment:

   User.new(params.permit(:name, :password))

Care should be taken to only whitelist values that are safe for a user (or attacker) to set. Foreign keys such as `account_id` are likely unsafe, allowing an attacker to manipulate records belonging to other accounts.

Brakeman will warn on potentially dangerous attributes that are whitelisted.

Brakeman will also warn about uses of `params.permit!`, since that allows everything.


### Rails Without Strong Parameters

In older versions of Rails, `attr_accessible` and `attr_protected` can be used to limit mass assignment.
However, Brakeman will warn unless `attr_accessible` is used, or mass assignment is completely disabled.

There are two different mass assignment warnings which can arise. The first is when mass assignment actually occurs, such as the example above. This results in a warning like

    Unprotected mass assignment near line 61: User.new(params[:user])

The other warning is raised whenever a model is found which does not use `attr_accessible`. This produces generic warnings like

    Mass assignment is not restricted using attr_accessible

with a list of affected models.

In Rails 3.1 and newer, mass assignment can easily be disabled:

    config.active_record.whitelist_attributes = true

Unfortunately, it can also easily be bypassed:

    User.new(params[:user], :without_protection => true)

Brakeman will warn on uses of `without_protection`.

### More Information

[Strong Parameters in Rails Security Guide](http://edgeguides.rubyonrails.org/action_controller_overview.html#strong-parameters)
[Mass Assignment in Rails Security Guide](http://guides.rubyonrails.org/v3.2.8/security.html#mass-assignment)

---

Back to [Warning Types](/docs/warning_types)
