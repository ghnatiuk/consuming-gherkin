%%{
  machine simple;
  
  action entering {
    # no-op
  }

  action leaving {
    # no-op
  }

  a = 'a' @leaving;
  b = 'b' >entering;
  main := a b;
}%%
