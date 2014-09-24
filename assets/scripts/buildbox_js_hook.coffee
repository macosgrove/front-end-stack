window.Graphbox ?= {}

$ -> 
  nav = new Graphbox.Injection.MenuNavigation
  nav.inject()