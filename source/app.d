import std.stdio;
import std.conv;
import raylib;
import packages.players;
import std.math;

void main()
{
	auto p1 = Player(Vector2(400, 90), Colors.RED);
	auto p2 = Player(Vector2(400, 710), Colors.BLUE);
	auto ball = Ball();

	validateRaylibBinding();
	InitWindow(800, 800, "Game");
	SetTargetFPS(60);

	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.BLACK);
		DrawLine(0, 400, 800, 400, Colors.GRAY);

		DrawLine(250, 1, 550, 1, Colors.WHITE);
		DrawLine(250, 799, 550, 799, Colors.WHITE);

		p1.drawPlayer();
		p2.drawPlayer();
		ball.drawBall();

        DrawText("Player 1 score :", 150, 300, 20, Colors.WHITE);       // Draw text (using default font)


		if (IsKeyPressed(KeyboardKey.KEY_R))
		{
			reset(p1, p2, ball);
		}

		const speedFactor = 7;

		if (IsKeyDown(KeyboardKey.KEY_D))
			if (p1.position.x < 800 - p1.radius)
			{
				if (sqrt((p1.position.x - ball.position.x) ^^ 2 + (
						p1.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p1.position.x += speedFactor;
				}
				else
				{
					p1.position.x -= 1;
					// p2.position.y += 1;
					// p2.position.y -= 1;
				}
			}

		if (IsKeyDown(KeyboardKey.KEY_A))
			if (p1.position.x > 0 + p1.radius)
			{
				if (sqrt((p1.position.x - ball.position.x) ^^ 2 + (
						p1.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p1.position.x -= speedFactor;
				}
				else
				{
					p1.position.x += 1;
					// p2.position.y += 1;
					// p2.position.y -= 1;
				}
			}
		if (IsKeyDown(KeyboardKey.KEY_W))
			if (p1.position.y > 0 + p1.radius)
			{
				if (sqrt((p1.position.x - ball.position.x) ^^ 2 + (
						p1.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p1.position.y -= speedFactor;
				}
				else
				{
					p1.position.y += 1;
					// p2.position.x += 1;
					// p2.position.x -= 1;

				}
			}
		if (IsKeyDown(KeyboardKey.KEY_S))
			if (p1.position.y < 400 - p1.radius)
			{
				if (sqrt((p1.position.x - ball.position.x) ^^ 2 + (
						p1.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p1.position.y += speedFactor;
				}
				else
				{
					p1.position.y -= 1;
					// p2.position.x += 1;
					// p2.position.x -= 1;
				}
			}

		if (IsKeyDown(KeyboardKey.KEY_RIGHT))
			if (p2.position.x < 800 - p2.radius)
			{
				if (sqrt((p2.position.x - ball.position.x) ^^ 2 + (
						p2.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p2.position.x += speedFactor;
				}
				else
				{
					p2.position.x -= 1;
					// p2.position.y += 1;
					// p2.position.y -= 1;
				}
			}

		if (IsKeyDown(KeyboardKey.KEY_LEFT))
			if (p2.position.x > 0 + p2.radius)
			{
				if (sqrt((p2.position.x - ball.position.x) ^^ 2 + (
						p2.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p2.position.x -= speedFactor;
				}
				else
				{
					p2.position.x += 1;
					// p2.position.y += 1;
					// p2.position.y -= 1;
				}
			}

		if (IsKeyDown(KeyboardKey.KEY_UP))
			if (p2.position.y > 400 + p2.radius)
			{
				if (sqrt((p2.position.x - ball.position.x) ^^ 2 + (
						p2.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p2.position.y -= speedFactor;
				}
				else
				{
					p2.position.y += 1;
					// p2.position.x += 1;
					// p2.position.x -= 1;

				}

			}

		if (IsKeyDown(KeyboardKey.KEY_DOWN))
			if (p2.position.y < 800 - p2.radius)
			{
				if (sqrt((p2.position.x - ball.position.x) ^^ 2 + (
						p2.position.y - ball.position.y) ^^ 2) >= 80)
				{
					p2.position.y += speedFactor;
				}
				else
				{
					p2.position.y -= 1;
					// p2.position.x += 1;
					// p2.position.x -= 1;
				}

			}

		ball.checkCollisionWithPlayer(p1);
		ball.checkCollisionWithPlayer(p2);
		ball.update(p1, p2);
		EndDrawing();
	}

	CloseWindow();
}
