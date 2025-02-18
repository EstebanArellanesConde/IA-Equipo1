// Este codigo encuentra la solucion con el mayor numero de caballos (necesita computar el maximo antes)
#include<bits/stdc++.h>
using namespace std;

vector<pair<int, int>> moves = {{-2, -2}, {-2, 2}, {2, -2}, {2, 2}};
vector<int> maxKnights = {0, 1, 4, 7, 8, 16, 24};
int n;

bool check(unsigned long long board, int i, int j) {
  int a, b;

  for (auto [x, y] : moves) {
    a = i + x;
    b = j + y;
    
    if (a >= 0 && a < n && b >= 0 && b < n && (board & (1LL << (a * n + b)))) {
      return false;
    }
  }
  
  return true;
}

void dfs(unsigned long long board, int i, int j, int knights) {
  if (i == n) {
    if (knights == maxKnights[n]) {
      cout << '\n' << knights << '\n';
      for (int i = 0; i < n; i++) {
		    for (int j = 0; j < n; j++) {
          cout << ((board & (1LL << (i * n + j))) ? 1 : 0) << ' ';
        }
        cout << '\n';
	    }

      exit(0);
    }
    
    return;
  }
 
  int x = (j + 1 < n) ? i : i + 1;
  int y = (j + 1 < n) ? j + 1 : 0;

  dfs(board, x, y, knights);
 
  if (check(board, i, j)) {
    board |= (1LL << (i * n + j));
    dfs(board, x, y, knights + 1);
  }
}

int main() {
  cout << "n = ";
	cin >> n;
 
  dfs(0LL, 0, 0, 0);
}
