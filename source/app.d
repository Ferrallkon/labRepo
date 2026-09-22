import std.stdio;
import std.conv;
import raylib;
import packages.players;

void main()
{
	auto p1 = Player(Vector2(50, 50), Colors.RED);
	auto p2 = Player(Vector2(750, 750), Colors.BLUE);
	auto ball = Ball();

	validateRaylibBinding();
	InitWindow(800, 800, "Game");
	SetTargetFPS(60);

	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.BLACK);
        DrawLine(0, 400, 800, 400, Colors.GRAY);

		p1.drawPlayer();
		p2.drawPlayer();
		ball.drawBall(); 

		if (IsKeyPressed(KeyboardKey.KEY_R))
		{ 
			reset(p1, p2, ball);
		}

		const speedFactor = 5.0f;

		if (IsKeyDown(KeyboardKey.KEY_D))
			if (p1.position.x < 800 - p1.radius)
				p1.position.x += speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_A))
			if (p1.position.x > 0 + p1.radius)
				p1.position.x -= speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_W))
			if (p1.position.y > 0 + p1.radius)
				p1.position.y -= speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_S))
			if (p1.position.y < 400 - p1.radius)
				p1.position.y += speedFactor;

		if (IsKeyDown(KeyboardKey.KEY_RIGHT))
			if (p2.position.x < 800 - p2.radius)
				p2.position.x += speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_LEFT))
			if (p2.position.x > 0 + p2.radius)
				p2.position.x -= speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_UP))
			if (p2.position.y > 400 + p2.radius)
				p2.position.y -= speedFactor;
		if (IsKeyDown(KeyboardKey.KEY_DOWN))
			if (p2.position.y < 800 - p2.radius)
				p2.position.y += speedFactor;

		ball.checkCollisionWithPlayer(p1);
		ball.checkCollisionWithPlayer(p2);
		ball.update();
		EndDrawing();
	}
	CloseWindow();
}