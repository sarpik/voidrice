#pragma  GCC optimize     ("O3")
#pragma  GCC target     ("sse4")

#if (0 || defined(DEBUG)) && !defined(EVAL)
	#include "custom_debug.h"
#else
	struct debug {
		template <class c> debug& operator <<(const c&) { return * this; } };
	#define imie(...) ""
#endif

#include         <bits/stdc++.h>
using             namespace std;

typedef           long long  ll;
typedef  unsigned long long ull;

const ll INF = 1e18;
const ll MOD = 1e9 + 7;



int main() {
	ios::sync_with_stdio(0);
	cin.tie(0);

	// const char* __fin  = "in" ; freopen(__fin , "r", stdin ); assert(std::ifstream(__fin).good());
	// const char* __fout = "out"; freopen(__fout, "w", stdout);


	<++>


	return 0;
}

