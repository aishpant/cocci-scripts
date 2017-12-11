/*
 * Convert DEVICE_ATTR() macro to DEVICE_ATTR_RO()
 * wherever applicable. Use with precaution as it
 * might rename the show function.
 */

@r@
identifier attr, show_fn;
declarer name DEVICE_ATTR;
@@

DEVICE_ATTR(attr, \(S_IRUGO\|0444\), show_fn, NULL);

@script: python p@
attr_show;
attr << r.attr;
show_fn << r.show_fn;
@@

// standardise the show fn name to {attr}_show
coccinelle.attr_show = attr + "_show"
print (show_fn)
@@
identifier r.attr, r.show_fn;
declarer name DEVICE_ATTR_RO;
@@

// change the attr declaration
- DEVICE_ATTR(attr, \(S_IRUGO\|0444\), show_fn, NULL);
+ DEVICE_ATTR_RO(attr);

@rr@
identifier r.show_fn, p.attr_show;
@@

// rename the show function
- show_fn
+ attr_show
	(...) {
	...
  }

@depends on rr@
identifier r.show_fn, p.attr_show;
@@

// rename fn usages
- show_fun
+ attr_show
