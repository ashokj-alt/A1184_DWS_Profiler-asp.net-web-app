<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="A1107_ParlePatalganga.SKUConfig" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Material Master</title>
    <link href="/../../global/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../global/fonts/font-awesome/font-awesome.min.css" rel="stylesheet" />
    <link href="/../../global/css/style.css" rel="stylesheet" />
    <style>
        body{
            height:100%;
            background-color:#dcdcdc;
        }
        .table_data tbody tr:hover {
            background-color: #ddd;
        }
        .table_data {
            height:650px;
            overflow:auto;
            display:block;
            width: 70%;
            margin-left: 15%;
            
            background-color:white;
        }
        .h4, h4 {
            font-size: 1.5rem;
            padding: 5px;
        }
        hr {
            margin-top: 0rem;
            margin-bottom: 0rem;
            border: 0;
            border-top: 1px solid rgba(0,0,0,.1);
        }
        .table thead tr th {
            background-color: #d3d3d3;
            
        }
            

            .table td, .table th {
                padding: .6rem;
                vertical-align: top;
                border-top: 1px solid #dee2e6;
            }

            .table tbody tr td button {
                padding: 4px;
                width: 75px;
            }

            .table tbody tr td {
                padding: 3px;
            }

                .table tbody tr td select {
                    width: 150px;
                    border: 1px solid lightgray;
                    padding: 4px;
                }
        
        #config{
            
        }
       
    </style>
</head>
<body>
    <div id="config">
        <div class="container-fluid">
            <div class="heading">
                <h4>Configure Material Master</h4>
            </div>
            <hr />

            <div class="body">
                <div class="table_data">
                    <table class="table">
                        <thead class="sticky">
                            <tr>

                                <th scope="col">Sr.No</th>
                                <th scope="col">Material Code</th>
                                <th scope="col">SKU</th>
                                <th scope="col">SKU ML</th>
                                <th scope="col">SKU Size</th>
                                <th scope="col">Action</th>


                            </tr>
                        </thead>
                        <tbody>
                            

                            

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            
                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            
                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                            <tr>

                                <td>1</td>
                                <td><strong>400005678</strong></td>
                                <td>Best Choice (Palm)500ml</td>
                                <td>Pouch Line</td>
                                <td>
                                    <select>
                                        <option>10</option>
                                        <option>20</option>
                                        <option>30</option>
                                        <option>40</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Save</button></td>

                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="/JS/jquery.min.js"></script>
    <script src="/JS/popper.min.js"></script>
    <script src="/JS/bootstrap.min.js"></script>
    <script src="/JS/custom.js"></script>
</body>
</html>
