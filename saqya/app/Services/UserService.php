<?php

namespace App\Services;

use App\Repositories\UserRepository;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Support\Facades\Auth;

class UserService extends BaseService
{
    public function __construct(UserRepository $baseRepository)
    {
        parent::__construct($baseRepository);
    }

    public function attemptLogin($data)
    {
        if ( ! Auth::attempt($data)) {
            throw new AuthenticationException('Login Failed, Email or Password is incorrect');
        }

        $user = $this->firstWhere([
            ['email', '=', $data['email']],
        ]);

        // Revoke old tokens
        $user->tokens()->delete();

        return $user->createToken('default')->plainTextToken;
    }
}
