local easing = {}

function easing:Linear(t, b, c, d)
  return c * t / d + b
end

function easing:InQuad(t, b, c, d)
  t = t / d
  return c * math.pow(t, 2) + b
end

function easing:OutQuad(t, b, c, d)
  t = t / d
  return -c * t * (t - 2) + b
end

function easing:InOutQuad(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return c / 2 * math.pow(t, 2) + b
  else
    return -c / 2 * ((t - 1) * (t - 3) - 1) + b
  end
end

return easing
