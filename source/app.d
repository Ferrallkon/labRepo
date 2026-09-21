import std.stdio;
import std.conv;
import raylib;

import packages.players;

void main()
{

	auto p1 = Player(Vector2(100.0f, 200.0f), Vector2(100.0f, 200.0f));
    auto ball = Ball();

	validateRaylibBinding();
	InitWindow(800, 800, "windowName");
	SetTargetFPS(60);

	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.RAYWHITE);

		// DrawRectangle(int posX, int posY, int width, int height, Color color);
		DrawRectangle(p1.position.x.to!int, p1.position.y.to!int, p1.position.x.to!int, p1.position.y.to!int, Colors
				.RED);

		// DrawCircle(int centerX, int centerY, float radius, Color color);      
        DrawCircle(ball.position.x.to!int, ball.position.y.to!int, ball.radius, Colors.GRAY);

		EndDrawing();
	}
	CloseWindow();
}
