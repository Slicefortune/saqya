<?php

declare(strict_types=1);

namespace App\Interfaces\Services;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

interface IBaseService
{
    /**
     * Create a new record
     */
    public function create(array $data): Model;

    /**
     * Find a record
     */
    public function findOrFail(int $id, array $relations = []): ?Model;

    /**
     * Update a record
     */
    public function update(int $id, array $data): ?Model;

    /**
     * Delete record
     */
    public function delete(int $id): bool;

    /**
     * All records
     */
    public function all(array $relations = []): Collection;

    /**
     * Get all records in descending order
     */
    public function latest(array $relations = []): Collection;

    /**
     * Get First record meeting the criteria
     */
    public function firstWhere(array $conditions, array $relations = []): ?Model;

    /**
     * Get all record meeting the criteria
     */
    public function allWhere(array $conditions, array $relations = []): Collection;

    /**
     * Get All Records paginated
     */
    public function allPaginated(int $paginate, array $conditions, array $relations = []): LengthAwarePaginator;
}
