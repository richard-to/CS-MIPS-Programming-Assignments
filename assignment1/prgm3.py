total = 0
upper = 0
lower = 0
chars = 'aBwdfe$%2s';

for c in chars:
    total += 1
    if c >= 'A' and c <= 'Z':
        upper += 1
    elif c >= 'a' and c <= 'z':
        lower += 1

print total
print upper
print lower
