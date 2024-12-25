<?php

namespace App\Exceptions;

use Exception;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Throwable;

class Handler extends ExceptionHandler
{
    /**
     * The list of the inputs that are never flashed to the session on validation exceptions.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     */
    public function register(): void
    {
        $this->reportable(function (Throwable $e): void {
            //
        });

        $this->renderable(function (NotFoundHttpException $e, Request $request) {
            if ($request->is('api/*') || $request->ajax()) {
                return response()->json([
                    'success' => false,
                    'errors' => [$e->getMessage()],
                ], $e->getStatusCode());
            }
        });

        $this->renderable(function (ValidationException $e, Request $request) {
            $errors = [];
            foreach ($e->errors() as $ers) {
                foreach ($ers as $error) {
                    $errors[] = $error;
                }
            }
            if ($request->is('api/*') || $request->ajax()) {
                return response()->json([
                    'success' => false,
                    'errors' => $errors,
                ], $e->status ?? 500);
            }
        });

        $this->renderable(function (AuthenticationException $e, Request $request) {
            if ($request->is('api/*') || $request->ajax()) {
                return response()->json([
                    'success' => false,
                    'errors' => [
                        'Unauthenticated.' === $e->getMessage() ? $e->getMessage() : 'Authentication failed! Please login again',
                    ],
                ], 401);
            }
        });

        $this->renderable(function (Exception $e, Request $request) {
            if ($request->is('api/*') || $request->ajax()) {
                dd($e);
                return response()->json([
                    'success' => false,
                    'errors' => [$e->getMessage()],
                ], 500);
            }
        });
    }

    /**
     * Always returns JSON response for API
     */
    protected function shouldReturnJson($request, Throwable $e): bool
    {
        return (bool)($request->is('api/*') || $request->ajax());

    }
}
