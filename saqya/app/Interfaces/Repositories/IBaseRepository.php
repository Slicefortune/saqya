<?php

declare(strict_types=1);

namespace App\Interfaces\Repositories;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

interface IBaseRepository
{
    /**
     * Return all data
     */
    public function all(array $relations = []): Collection;

    /**
     * Return all the data in descending order
     */
    public function latest(array $relations = []): Collection;

    /**
     * Create new record
     */
    public function create(array $data): Model;

    /**
     * Find record based on primary key
     */
    public function findOrFail(int $id, array $relations = []): ?Model;

    /**
     * Find all records matching conditions
     */
    public function allWhere(array $conditions, array $relations = []): Collection;

    /**
     * Find all records matching conditions
     */
    public function whereIn(string $column, array $values, array $relations = []): Collection;

    /**
     * Find first record matching conditions
     */
    public function firstWhere(array $conditions, array $relations = []): ?Model;

    /**
     * Update record
     */
    public function update(int $id, array $data): ?Model;

    /**
     * Delete record
     */
    public function delete(int $id): bool;

    /**
     * Get All Records paginated
     */
    public function paginate(int $paginate, array $conditions, array $relations = []): LengthAwarePaginator;
}
