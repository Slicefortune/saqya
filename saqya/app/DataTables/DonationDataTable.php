<?php

namespace App\DataTables;

use App\Models\Donation;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Illuminate\Support\Facades\Storage;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;

class DonationDataTable extends DataTable
{
    /**
     * Build the DataTable class.
     *
     * @param QueryBuilder $query Results from query() method.
     */
    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        return (new EloquentDataTable($query))
        ->editColumn('product_id', fn ($donation) => $donation->product->name)

        ->editColumn('quantity', fn ($donation) => "<div class=''>{$donation->quantity}</div>")

            ->editColumn('payment_method', fn ($donation) => "<div class='badge {$donation->payment_method->color()}'>{$donation->payment_method->label()}</div>")
            ->rawColumns([ 'quantity', 'payment_method','product_id'])
            ->setRowId('id');
    }

    /**
     * Get the query source of dataTable.
     */
    public function query(Donation $model): QueryBuilder
    {
        return $model->newQuery();
    }

    /**
     * Optional method if you want to use the html builder.
     */
    public function html(): HtmlBuilder
    {
        return $this->builder()
            ->setTableId('donation-table')
            ->columns($this->getColumns())
            ->minifiedAjax()
                    //->dom('Bfrtip')
            ->orderBy(1)
            ->selectStyleSingle()
            ->buttons([
                Button::make('excel'),
                Button::make('csv'),
                Button::make('pdf'),
                Button::make('print'),
                Button::make('reset'),
                Button::make('reload')
            ]);
    }

    /**
     * Get the dataTable columns definition.
     */
    public function getColumns(): array
    {
        return [
            Column::make('product_id')->title('Product'),

            Column::make('mosque_name'),
            Column::make('mosque_address'),
            Column::make('donated_at'),
            Column::make('quantity'),
            Column::make('total'),
            Column::make('payment_method'),


        ];
    }

    /**
     * Get the filename for export.
     */
    protected function filename(): string
    {
        return 'Donation_' . date('YmdHis');
    }
}