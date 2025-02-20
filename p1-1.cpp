// Este codigo encuentra la solucion con el mayor numero de caballos (necesita computar el maximo antes)
#include<bits/stdc++.h>
using namespace std;

vector<pair<int, int>> moves = {{-2, -2}, {-2, 2}, {2, -2}, {2, 2}};
vector<int> maxKnights = {0, 1, 4, 7, 8, 16, 24};
int n;

bool check(vector<vector<bool>> board, int i, int j) {
  int a, b;

  for (auto [x, y] : moves) {
    a = i + x;
    b = j + y;
 
    if (a >= 0 && a < n && b >= 0 && b < n && board[a][b]) {
      return false;
    }
  }
 
  return true;
}

void print(vector<vector<bool>> board) {
  for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
      cout << (int)board[i][j] << ' ';
    }
    cout << '\n';
	}
  cout << '\n';
}

void dfs(vector<vector<bool>> board, int i, int j, int knights) {
  if (i == n) {
    if (knights == maxKnights[n]) {
      cout << "\nNumero de caballos: " << knights << "\n\n";
      print(board); 
      exit(0);
    }
 
    return;
  }
 
  print(board);

  int x = (j + 1 < n) ? i : i + 1;
  int y = (j + 1 < n) ? j + 1 : 0;

  if (check(board, i, j)) {
    board[i][j] = 1;
    dfs(board, x, y, knights + 1);
  }

  board[i][j] = 0;
  dfs(board, x, y, knights);
}

int main() {
  cout << "Ingrese el valor de n\n$ ";
	cin >> n;
 
  dfs(vector<vector<bool>>(n, vector<bool>(n, 0)), 0, 0, 0);
}
