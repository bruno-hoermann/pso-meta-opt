function y = bound(x,bounds)
  % return bounded value clipped between bl and bu
  y=min(max(x,bounds(1,:)),bounds(2,:));