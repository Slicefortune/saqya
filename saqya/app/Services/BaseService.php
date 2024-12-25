<?php

declare(strict_types=1);

namespace App\Services;

use App\Interfaces\Repositories\IBaseRepository;
use App\Interfaces\Services\IBaseService;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

class BaseService implements IBaseService
{
    public IBaseRepository $repository;

    public function __construct(IBaseRepository $baseRepository)
    {
        $this->repository = $baseRepository;
    }

    /**
     * Create a new record
     */
    public function create(array $data): Model
    {
        return $this->repository->create($data);
    }

    /**
     * Find a record
     */
    public function findOrFail(int $id, array $relations = []): ?Model
    {
        return $this->repository->findOrFail($id, $relations);
    }

    /**
     * Update a record
     */
    public function update(int $id, array $data): ?Model
    {
        return $this->repository->update($id, $data);
    }

    /**
     * Delete record
     */
    public function delete(int $id): bool
    {
        return $this->repository->delete($id);
    }

    /**
     * All records
     */
    public function all(array $relations = []): Collection
    {
        return $this->repository->all($relations);
    }

    /**
     * Get all records in descending order
     */
    public function latest(array $relations = []): Collection
    {
        return $this->repository->latest($relations);
    }

    /**
     * Get first record meeting the criteria
     */
    public function firstWhere(array $conditions, array $relations = []): ?Model
    {
        return $this->repository->firstWhere($conditions, $relations);
    }

    /**
     * Get all record meeting the criteria
     */
    public function allWhere(array $conditions, array $relations = []): Collection
    {
        return $this->repository->allWhere($conditions, $relations);
    }

    /**
     * Get All Records paginated
     */
    public function allPaginated(int $paginate, array $conditions = [], array $relations = []): LengthAwarePaginator
    {
        return $this->repository->paginate($paginate, $conditions, $relations);
    }

    /**
     * Get All Records Ordered By Order
     */
    public function getAllOrderBy(string $column, string $order = 'ASC'): Collection|array
    {
        return $this->repository->orderBy($column, $order);
    }
}
