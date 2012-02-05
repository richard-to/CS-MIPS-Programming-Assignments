score = 102
grade = '?'
valid = 1

if score < 0 or score > 100:
    valid = 0
    grade = '?'
elif score >= 90:
    grade = 'A'
elif score >= 80:
    grade = 'B'
elif score >= 70:
    grade = 'C'
elif score >= 60:
    grade = 'D'
else:
    grade = 'F'         
    

