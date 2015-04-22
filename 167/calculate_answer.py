from pq import U
from period import Period

result = 0
for n in range(2, 11):
    v = 2*n + 1
    u = U(v)
    period = Period(u, 100)
    x = period.compute(10**11)
    print str(v) + ": " + str(x)
    print len(period.period)
    result += x
print result
