#pragma  GCC optimize     ("O3")
#pragma  GCC target     ("sse4")

#if (0 || defined(DEBUG)) && !defined(EVAL)
	#include "debug.h" // https://github.com/kiprasmel/debug.h
#else
	struct debug {
		template <class c> debug& operator <<(const c&) { return * this; } };
	#define imie(...) ""
#endif

#include         <bits/stdc++.h>
using             namespace std;

typedef           long long  ll;
typedef  unsigned long long ull;

constexpr ll  INFLL =  1e18 + 8;
constexpr int INF   =  1e9  + 8;
constexpr int MOD   =  1e9  + 7;

void test_case(ll T) {
	<++>
}

int main() {
	ios::sync_with_stdio(0);
	cin.tie(0);

	// const char* __fin  = "in" ; freopen(__fin , "r", stdin ); assert(std::ifstream(__fin).good());
	// const char* __fout = "out"; freopen(__fout, "w", stdout);

	int t;
	cin >> t;

	for (int T = 0; T < t; T++) {
		test_case(T);
	}

	return 0;
}

