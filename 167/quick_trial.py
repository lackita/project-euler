from period import Period
from pq import U

p = Period(U(5), 100, 1000)
print p.compute(10**11)
