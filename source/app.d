import std.stdio;
import std.conv;
import raylib;

import packages.players;

void main()
{

	auto p1 = Player(Vector2(10, 10), Vector2(100, 50), Colors.RED);
	auto p2 = Player(Vector2(700, 700), Vector2(100, 50), Colors.BLUE);
	auto ball = Ball();

	validateRaylibBinding();
	InitWindow(800, 800, "windowName");
	SetTargetFPS(60);

	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.RAYWHITE);

		DrawRectangle(p1.position.x.to!int, p1.position.y.to!int, p1.size.x.to!int, p1.size.y.to!int, p1
				.color);

		DrawRectangle(p2.position.x.to!int, p2.position.y.to!int, p2.size.x.to!int, p2.size.y.to!int, p2
				.color);

		if (IsKeyDown(KeyboardKey.KEY_RIGHT))
			p1.position.x += 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_LEFT))
			p1.position.x -= 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_UP))
			p1.position.y -= 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_DOWN))
			p1.position.y += 2.0f;

		if (IsKeyDown(KeyboardKey.KEY_D))
			p2.position.x += 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_A))
			p2.position.x -= 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_W))
			p2.position.y -= 2.0f;
		if (IsKeyDown(KeyboardKey.KEY_S))
			p2.position.y += 2.0f;
		// DrawCircle(int centerX, int centerY, float radius, Color color);      
		DrawCircle(ball.position.x.to!int, ball.position.y.to!int, ball.radius, Colors.GRAY);

		EndDrawing();
	}
	CloseWindow();
}
